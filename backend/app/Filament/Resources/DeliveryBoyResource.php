<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DeliveryBoyResource\Pages;
use App\Models\DeliveryBoy;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Hash;

class DeliveryBoyResource extends Resource
{
    protected static ?string $model = DeliveryBoy::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    protected static ?string $navigationGroup = 'Operations';

    protected static ?int $navigationSort = 2;

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $modelLabel = 'Delivery Boy';

    protected static ?string $pluralModelLabel = 'Delivery Boys';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('e.g., Ahmed Ali'),

                        Forms\Components\TextInput::make('phone')
                            ->required()
                            ->maxLength(50)
                            ->tel()
                            ->placeholder('e.g., 03001234567'),

                        Forms\Components\TextInput::make('payment')
                            ->numeric()
                            ->prefix('PKR')
                            ->default(0)
                            ->minValue(0)
                            ->step(0.01)
                            ->placeholder('0.00')
                            ->helperText('Total payment/earnings'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('App Login Account')
                    ->description('Link a user account so this rider can log into the mobile app.')
                    ->schema([
                        Forms\Components\Select::make('user_id')
                            ->label('Linked User Account')
                            ->relationship('user', 'email')
                            ->searchable(['email', 'firstname', 'lastname'])
                            ->preload()
                            ->placeholder('No account linked')
                            ->helperText('Only rider-role accounts are shown. Use the "Create Login" action to create one.'),
                    ])
                    ->collapsible(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('phone')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('payment')
                    ->money('PKR')
                    ->sortable(),

                Tables\Columns\TextColumn::make('user.email')
                    ->label('App Login')
                    ->placeholder('No account')
                    ->icon('heroicon-o-device-phone-mobile')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\Action::make('createLogin')
                    ->label('Create Login')
                    ->icon('heroicon-o-user-plus')
                    ->color('success')
                    ->visible(fn (DeliveryBoy $record): bool => $record->user_id === null)
                    ->form([
                        Forms\Components\TextInput::make('email')
                            ->email()
                            ->required()
                            ->unique('users', 'email')
                            ->placeholder('rider@cubagroceries.com'),

                        Forms\Components\TextInput::make('password')
                            ->password()
                            ->required()
                            ->minLength(6)
                            ->placeholder('Min 6 characters'),
                    ])
                    ->action(function (DeliveryBoy $record, array $data): void {
                        $names = explode(' ', $record->name, 2);

                        $user = User::create([
                            'identity' => $record->phone,
                            'email' => $data['email'],
                            'firstname' => $names[0],
                            'lastname' => $names[1] ?? '',
                            'password' => Hash::make($data['password']),
                            'role' => 'rider',
                        ]);

                        $record->update(['user_id' => $user->id]);

                        Notification::make()
                            ->success()
                            ->title('Login Created')
                            ->body("Account {$data['email']} created for {$record->name}.")
                            ->send();
                    })
                    ->requiresConfirmation()
                    ->modalHeading(fn (DeliveryBoy $record) => "Create Login for {$record->name}"),

                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('id', 'asc');
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDeliveryBoys::route('/'),
            'create' => Pages\CreateDeliveryBoy::route('/create'),
            'edit' => Pages\EditDeliveryBoy::route('/{record}/edit'),
        ];
    }
}
