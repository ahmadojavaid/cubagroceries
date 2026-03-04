<?php

namespace App\Filament\Pages;

use App\Models\User;
use App\Notifications\ManualPush;
use App\Services\FcmService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;

class SendPushNotification extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-paper-airplane';

    protected static ?string $navigationGroup = 'System';

    protected static ?int $navigationSort = 2;

    protected static ?string $title = 'Send Push Notification';

    protected static ?string $navigationLabel = 'Push Notifications';

    protected static string $view = 'filament.pages.send-push-notification';

    // Form state
    public string $target = 'all';
    public ?int $customer_id = null;
    public string $push_title = '';
    public string $push_message = '';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Compose Notification')
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
                                    ->mapWithKeys(fn (User $u) => [$u->id => "{$u->full_name} ({$u->email})"])
                                    ->toArray()
                            )
                            ->visible(fn (Forms\Get $get) => $get('target') === 'individual')
                            ->required(fn (Forms\Get $get) => $get('target') === 'individual'),

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
                    ])
                    ->columns(1),
            ])
            ->statePath('data');
    }

    // Override to use properties directly instead of $data array
    protected function getFormStatePath(): ?string
    {
        return null;
    }

    public function send(): void
    {
        $this->validate([
            'push_title' => 'required|string|max:100',
            'push_message' => 'required|string|max:500',
            'customer_id' => $this->target === 'individual' ? 'required|exists:users,id' : 'nullable',
        ]);

        if ($this->target === 'individual') {
            $this->sendToIndividual();
        } else {
            $this->sendToAll();
        }
    }

    private function sendToIndividual(): void
    {
        $user = User::find($this->customer_id);

        if (! $user) {
            Notification::make()->danger()->title('Customer not found.')->send();
            return;
        }

        $sent = false;
        if ($user->fcm_token) {
            $sent = FcmService::sendToDevice(
                $user->fcm_token,
                $this->push_title,
                $this->push_message,
                ['type' => 'manual_push'],
            );
        }

        // Save in database
        $user->notify(new ManualPush($this->push_title, $this->push_message));

        Notification::make()
            ->title($sent ? 'Push Sent!' : 'Notification Saved')
            ->body($sent
                ? "Notification sent to {$user->full_name}."
                : "Saved to {$user->full_name}'s notifications. Push delivery failed (no token or offline).")
            ->color($sent ? 'success' : 'warning')
            ->send();

        $this->resetForm();
    }

    private function sendToAll(): void
    {
        $users = User::where('role', 'customer')->get();
        $sentCount = 0;
        $totalCount = $users->count();

        foreach ($users as $user) {
            // Save in database for all
            $user->notify(new ManualPush($this->push_title, $this->push_message));

            // Send push to those with tokens
            if ($user->fcm_token) {
                $success = FcmService::sendToDevice(
                    $user->fcm_token,
                    $this->push_title,
                    $this->push_message,
                    ['type' => 'manual_push'],
                );
                if ($success) $sentCount++;
            }
        }

        Notification::make()
            ->success()
            ->title('Broadcast Complete')
            ->body("Notification saved for {$totalCount} customers. Push delivered to {$sentCount} devices.")
            ->send();

        $this->resetForm();
    }

    private function resetForm(): void
    {
        $this->push_title = '';
        $this->push_message = '';
        $this->customer_id = null;
    }
}
