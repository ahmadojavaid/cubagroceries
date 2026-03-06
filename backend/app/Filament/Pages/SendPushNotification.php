<?php

namespace App\Filament\Pages;

use App\Models\User;
use App\Notifications\ManualPush;
use App\Services\FcmService;
use Filament\Forms;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class SendPushNotification extends Page implements HasForms
{
    use InteractsWithForms;

    public static function canAccess(): bool
    {
        return auth('portal')->user()?->isAdmin() ?? false;
    }

    protected static ?string $navigationIcon = 'heroicon-o-paper-airplane';

    protected static ?string $navigationGroup = 'System';

    protected static ?int $navigationSort = 2;

    protected static ?string $title = 'Send Push Notification';

    protected static ?string $navigationLabel = 'Push Notifications';

    protected static string $view = 'filament.pages.send-push-notification';

    // Form state — bound to Livewire properties directly
    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill([
            'target' => 'all',
            'customer_id' => null,
            'push_title' => '',
            'push_message' => '',
            'image' => null,
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Compose Notification')
                    ->description('Send a push notification to all customers or a specific individual. Notifications are saved in-app and delivered via push.')
                    ->schema([
                        Forms\Components\Radio::make('target')
                            ->label('Send To')
                            ->options([
                                'all' => 'All Customers',
                                'individual' => 'Individual Customer',
                            ])
                            ->default('all')
                            ->inline()
                            ->live()
                            ->required(),

                        Forms\Components\Select::make('customer_id')
                            ->label('Select Customer')
                            ->searchable()
                            ->getSearchResultsUsing(fn (string $search) =>
                                User::where('role', 'customer')
                                    ->where(fn ($q) => $q
                                        ->where('firstname', 'ilike', "%{$search}%")
                                        ->orWhere('lastname', 'ilike', "%{$search}%")
                                        ->orWhere('email', 'ilike', "%{$search}%")
                                        ->orWhere('identity', 'like', "%{$search}%")
                                    )
                                    ->limit(20)
                                    ->get()
                                    ->mapWithKeys(fn (User $u) => [
                                        $u->id => "{$u->firstname} {$u->lastname} — {$u->identity}" . ($u->email ? " ({$u->email})" : ''),
                                    ])
                                    ->toArray()
                            )
                            ->getOptionLabelUsing(function ($value): ?string {
                                $user = User::find($value);
                                if (! $user) return null;
                                return "{$user->firstname} {$user->lastname} — {$user->identity}" . ($user->email ? " ({$user->email})" : '');
                            })
                            ->visible(fn (Forms\Get $get) => $get('target') === 'individual')
                            ->required(fn (Forms\Get $get) => $get('target') === 'individual')
                            ->helperText('Search by name, email, or phone number'),

                        Forms\Components\TextInput::make('push_title')
                            ->label('Title')
                            ->placeholder('e.g. Weekend Sale! 🛒')
                            ->required()
                            ->maxLength(100),

                        Forms\Components\Textarea::make('push_message')
                            ->label('Message')
                            ->placeholder('e.g. Get 20% off on all fresh vegetables this weekend!')
                            ->required()
                            ->maxLength(500)
                            ->rows(4),

                        Forms\Components\FileUpload::make('image')
                            ->label('Image (optional)')
                            ->image()
                            ->maxSize(2048) // 2MB
                            ->directory('push-images')
                            ->disk('public')
                            ->imageResizeMode('cover')
                            ->imageCropAspectRatio('16:9')
                            ->imageResizeTargetWidth('1024')
                            ->imageResizeTargetHeight('576')
                            ->helperText('Recommended: 1024×576px (16:9). Max 2MB. JPG or PNG.'),
                    ])
                    ->columns(1),
            ])
            ->statePath('data');
    }

    public function send(): void
    {
        $state = $this->form->getState();

        $target = $state['target'];
        $title = $state['push_title'];
        $message = $state['push_message'];
        $customerId = $state['customer_id'] ?? null;
        $imagePath = $state['image'] ?? null;

        // Build full image URL if an image was uploaded
        $imageUrl = null;
        if ($imagePath) {
            $imageUrl = Storage::disk('public')->url($imagePath);
        }

        if ($target === 'individual') {
            $this->sendToIndividual($customerId, $title, $message, $imageUrl);
        } else {
            $this->sendToAll($title, $message, $imageUrl);
        }
    }

    private function sendToIndividual(?int $customerId, string $title, string $message, ?string $imageUrl): void
    {
        $user = User::find($customerId);

        if (! $user) {
            Notification::make()->danger()->title('Customer not found.')->send();
            return;
        }

        $sent = false;
        if ($user->fcm_token) {
            $sent = FcmService::sendToDevice(
                fcmToken: $user->fcm_token,
                title: $title,
                body: $message,
                data: ['type' => 'manual_push'],
                channelId: 'order_notifications',
                imageUrl: $imageUrl,
            );
        }

        // Save in database notification
        $user->notify(new ManualPush($title, $message, $imageUrl));

        Notification::make()
            ->title($sent ? 'Push Sent!' : 'Notification Saved')
            ->body($sent
                ? "Push notification sent to {$user->full_name}."
                : "Saved to {$user->full_name}'s inbox. Push delivery failed (no FCM token or device offline).")
            ->color($sent ? 'success' : 'warning')
            ->send();

        $this->form->fill([
            'target' => 'all',
            'customer_id' => null,
            'push_title' => '',
            'push_message' => '',
            'image' => null,
        ]);
    }

    private function sendToAll(string $title, string $message, ?string $imageUrl): void
    {
        $users = User::where('role', 'customer')->get();
        $sentCount = 0;
        $totalCount = $users->count();

        foreach ($users as $user) {
            // Save in database for all
            $user->notify(new ManualPush($title, $message, $imageUrl));

            // Send push to those with tokens
            if ($user->fcm_token) {
                $success = FcmService::sendToDevice(
                    fcmToken: $user->fcm_token,
                    title: $title,
                    body: $message,
                    data: ['type' => 'manual_push'],
                    channelId: 'order_notifications',
                    imageUrl: $imageUrl,
                );
                if ($success) $sentCount++;
            }
        }

        Notification::make()
            ->success()
            ->title('Broadcast Complete')
            ->body("Notification saved for {$totalCount} customers. Push delivered to {$sentCount} devices.")
            ->send();

        $this->form->fill([
            'target' => 'all',
            'customer_id' => null,
            'push_title' => '',
            'push_message' => '',
            'image' => null,
        ]);
    }
}
