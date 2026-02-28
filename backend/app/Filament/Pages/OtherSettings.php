<?php

namespace App\Filament\Pages;

use App\Models\AppSetting;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;

class OtherSettings extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-cog-6-tooth';

    protected static ?string $navigationGroup = 'System';

    protected static ?int $navigationSort = 2;

    protected static ?string $title = 'Other Settings';

    protected static ?string $slug = 'other-settings';

    protected static string $view = 'filament.pages.other-settings';

    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill([
            'app_name' => AppSetting::getValue('app_name', 'Cuba Groceries'),
            'contact_email' => AppSetting::getValue('contact_email', ''),
            'contact_phone' => AppSetting::getValue('contact_phone', ''),
            'whatsapp_number' => AppSetting::getValue('whatsapp_number', ''),
            'min_order_amount' => AppSetting::getValue('min_order_amount', '0'),
            'currency_symbol' => AppSetting::getValue('currency_symbol', 'Rs'),
            'delivery_time_text' => AppSetting::getValue('delivery_time_text', '30-60 minutes'),
            'about_us' => AppSetting::getValue('about_us', ''),
            'terms_and_conditions' => AppSetting::getValue('terms_and_conditions', ''),
            'privacy_policy' => AppSetting::getValue('privacy_policy', ''),
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('General')
                    ->schema([
                        Forms\Components\TextInput::make('app_name')
                            ->label('App Name')
                            ->required()
                            ->maxLength(100),

                        Forms\Components\TextInput::make('currency_symbol')
                            ->maxLength(10)
                            ->default('Rs'),

                        Forms\Components\TextInput::make('min_order_amount')
                            ->label('Minimum Order Amount')
                            ->numeric()
                            ->prefix('Rs'),

                        Forms\Components\TextInput::make('delivery_time_text')
                            ->label('Delivery Time Text')
                            ->placeholder('e.g. 30-60 minutes'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Contact Information')
                    ->schema([
                        Forms\Components\TextInput::make('contact_email')
                            ->email()
                            ->maxLength(255),

                        Forms\Components\TextInput::make('contact_phone')
                            ->tel()
                            ->maxLength(50),

                        Forms\Components\TextInput::make('whatsapp_number')
                            ->tel()
                            ->maxLength(50),
                    ])
                    ->columns(3),

                Forms\Components\Section::make('Legal Pages')
                    ->schema([
                        Forms\Components\RichEditor::make('about_us')
                            ->label('About Us'),

                        Forms\Components\RichEditor::make('terms_and_conditions')
                            ->label('Terms & Conditions'),

                        Forms\Components\RichEditor::make('privacy_policy')
                            ->label('Privacy Policy'),
                    ]),
            ])
            ->statePath('data');
    }

    public function save(): void
    {
        $data = $this->form->getState();

        foreach ($data as $key => $value) {
            AppSetting::setValue($key, $value);
        }

        Notification::make()
            ->title('Settings saved')
            ->success()
            ->send();
    }

    protected function getFormActions(): array
    {
        return [
            Forms\Components\Actions\Action::make('save')
                ->label('Save Settings')
                ->submit('save'),
        ];
    }
}
