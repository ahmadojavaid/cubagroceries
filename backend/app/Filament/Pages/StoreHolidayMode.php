<?php

namespace App\Filament\Pages;

use App\Models\AppSetting;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;

class StoreHolidayMode extends Page
{
    public static function canAccess(): bool
    {
        return auth('portal')->user()?->isAdmin() ?? false;
    }

    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';

    protected static ?string $navigationGroup = 'Operations';

    protected static ?int $navigationSort = 1;

    protected static ?string $title = 'Store Holiday Mode';

    protected static ?string $navigationLabel = 'Holiday Mode';

    protected static string $view = 'filament.pages.store-holiday-mode';

    // Form state
    public bool $is_store_offline = false;
    public ?string $holiday_title = '';
    public ?string $holiday_message = '';
    public ?string $holiday_image = null;
    public ?string $holiday_start = null;
    public ?string $holiday_end = null;
    public bool $allow_advance_orders = true;

    public function mount(): void
    {
        $this->is_store_offline = AppSetting::getValue('is_store_offline', '0') === '1';
        $this->holiday_title = AppSetting::getValue('holiday_title', '');
        $this->holiday_message = AppSetting::getValue('holiday_message', '');
        $this->holiday_image = AppSetting::getValue('holiday_image', null);
        $this->holiday_start = AppSetting::getValue('holiday_start', null);
        $this->holiday_end = AppSetting::getValue('holiday_end', null);
        $this->allow_advance_orders = AppSetting::getValue('allow_advance_orders', '1') === '1';

        $this->form->fill([
            'holiday_title' => $this->holiday_title,
            'holiday_message' => $this->holiday_message,
            'holiday_image' => $this->holiday_image,
            'holiday_start' => $this->holiday_start,
            'holiday_end' => $this->holiday_end,
            'allow_advance_orders' => $this->allow_advance_orders,
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Holiday Details')
                    ->description('Configure the message shown to customers when the store is offline.')
                    ->schema([
                        Forms\Components\TextInput::make('holiday_title')
                            ->label('Title')
                            ->placeholder('e.g. Eid Holiday Break 🌙')
                            ->maxLength(200),

                        Forms\Components\Textarea::make('holiday_message')
                            ->label('Message')
                            ->placeholder('e.g. We are closed for Eid celebrations. Orders will resume on Monday!')
                            ->maxLength(1000)
                            ->rows(3),

                        Forms\Components\FileUpload::make('holiday_image')
                            ->label('Banner Image (optional)')
                            ->image()
                            ->imageResizeMode('cover')
                            ->imageCropAspectRatio('16:9')
                            ->directory('holidays')
                            ->maxSize(2048)
                            ->helperText('16:9 ratio recommended. Max 2MB.'),
                    ]),

                Forms\Components\Section::make('Schedule')
                    ->description('Set start/end dates. Leave empty for indefinite offline mode (use the toggle).')
                    ->schema([
                        Forms\Components\DateTimePicker::make('holiday_start')
                            ->label('Goes Offline At')
                            ->seconds(false)
                            ->native(false),

                        Forms\Components\DateTimePicker::make('holiday_end')
                            ->label('Goes Back Online At')
                            ->seconds(false)
                            ->native(false)
                            ->after('holiday_start'),

                        Forms\Components\Toggle::make('allow_advance_orders')
                            ->label('Allow "Order for Later"')
                            ->helperText('If enabled, customers can still browse and place orders during holiday mode. Orders will be processed when the store reopens.')
                            ->default(true),
                    ])
                    ->columns(2),
            ])
            ->statePath('data');
    }

    // Override to use properties directly
    protected function getFormStatePath(): ?string
    {
        return null;
    }

    /**
     * Instant toggle: take store offline/online immediately.
     */
    public function toggleOnlineStatus(): void
    {
        $this->is_store_offline = ! $this->is_store_offline;
        AppSetting::setValue('is_store_offline', $this->is_store_offline ? '1' : '0');

        Notification::make()
            ->title($this->is_store_offline ? 'Store is now OFFLINE' : 'Store is now ONLINE')
            ->icon($this->is_store_offline ? 'heroicon-o-x-circle' : 'heroicon-o-check-circle')
            ->color($this->is_store_offline ? 'danger' : 'success')
            ->send();
    }

    /**
     * Save the holiday details (title, message, image, schedule).
     */
    public function save(): void
    {
        $this->validate([
            'holiday_title' => 'nullable|string|max:200',
            'holiday_message' => 'nullable|string|max:1000',
            'holiday_start' => 'nullable|date',
            'holiday_end' => 'nullable|date|after:holiday_start',
        ]);

        AppSetting::setValue('holiday_title', $this->holiday_title ?: null);
        AppSetting::setValue('holiday_message', $this->holiday_message ?: null);
        AppSetting::setValue('holiday_start', $this->holiday_start);
        AppSetting::setValue('holiday_end', $this->holiday_end);
        AppSetting::setValue('allow_advance_orders', $this->allow_advance_orders ? '1' : '0');

        // Handle image upload
        if ($this->holiday_image && $this->holiday_image instanceof TemporaryUploadedFile) {
            $path = $this->holiday_image->store('holidays', 'public');
            AppSetting::setValue('holiday_image', $path);
            $this->holiday_image = $path;
        } elseif ($this->holiday_image === null) {
            AppSetting::setValue('holiday_image', null);
        }

        Notification::make()
            ->title('Holiday settings saved')
            ->success()
            ->send();
    }

    /**
     * Helper: Check if store is currently in holiday mode.
     */
    public static function isStoreOffline(): bool
    {
        // Check instant toggle
        $manualOffline = AppSetting::getValue('is_store_offline', '0') === '1';
        if ($manualOffline) return true;

        // Check scheduled holiday
        $start = AppSetting::getValue('holiday_start');
        $end = AppSetting::getValue('holiday_end');

        if ($start && $end) {
            $now = now();
            return $now->between($start, $end);
        }

        return false;
    }

    /**
     * Get the holiday data for the API response.
     */
    public static function getHolidayData(): ?array
    {
        if (! self::isStoreOffline()) return null;

        $image = AppSetting::getValue('holiday_image');

        return [
            'is_offline' => true,
            'title' => AppSetting::getValue('holiday_title', 'We\'re currently closed'),
            'message' => AppSetting::getValue('holiday_message', 'We\'ll be back soon!'),
            'image' => $image ? asset('storage/' . $image) : null,
            'holiday_end' => AppSetting::getValue('holiday_end'),
            'allow_advance_orders' => AppSetting::getValue('allow_advance_orders', '1') === '1',
        ];
    }
}
