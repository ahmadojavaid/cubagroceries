<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CustomerResource\Pages;
use App\Filament\Resources\CustomerResource\RelationManagers;
use App\Models\User;
use App\Models\WalletTransaction;
use Filament\Forms;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CustomerResource extends Resource
{
    public static function canAccess(): bool
    {
        return auth('portal')->user()?->isAdmin() ?? false;
    }

    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static ?string $navigationGroup = 'Users';

    protected static ?int $navigationSort = 1;

    protected static ?string $modelLabel = 'Customer';

    protected static ?string $pluralModelLabel = 'Customers';

    protected static ?string $slug = 'customers';

    public static function canCreate(): bool
    {
        return false;
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('full_name')
                    ->label('Name')
                    ->searchable(['firstname', 'lastname'])
                    ->sortable(['firstname']),

                Tables\Columns\TextColumn::make('email')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('identity')
                    ->label('Phone')
                    ->searchable(),

                Tables\Columns\TextColumn::make('wallet_amount')
                    ->label('Wallet')
                    ->money('PKR')
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Joined')
                    ->dateTime('M d, Y')
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),

                Tables\Actions\Action::make('topUp')
                    ->label('Top Up')
                    ->icon('heroicon-o-plus-circle')
                    ->color('success')
                    ->form([
                        Forms\Components\TextInput::make('amount')
                            ->label('Amount (PKR)')
                            ->numeric()
                            ->required()
                            ->minValue(1)
                            ->maxValue(100000),
                        Forms\Components\TextInput::make('note')
                            ->label('Note')
                            ->placeholder('Reason for top-up')
                            ->maxLength(255),
                    ])
                    ->action(function (User $record, array $data): void {
                        $record->increment('wallet_amount', $data['amount']);

                        WalletTransaction::recordCredit(
                            $record->id,
                            $data['amount'],
                            'admin_topup',
                            note: $data['note'] ?? null,
                        );

                        Notification::make()
                            ->success()
                            ->title('Wallet Topped Up')
                            ->body("Rs {$data['amount']} added to {$record->full_name}'s wallet. New balance: Rs {$record->fresh()->wallet_amount}")
                            ->send();
                    })
                    ->requiresConfirmation()
                    ->modalHeading(fn (User $record) => "Top Up: {$record->full_name}"),

                Tables\Actions\Action::make('deduct')
                    ->label('Deduct')
                    ->icon('heroicon-o-minus-circle')
                    ->color('danger')
                    ->form(fn (User $record) => [
                        Forms\Components\TextInput::make('amount')
                            ->label('Amount (PKR)')
                            ->numeric()
                            ->required()
                            ->minValue(1)
                            ->maxValue((float) $record->wallet_amount),
                        Forms\Components\TextInput::make('note')
                            ->label('Note')
                            ->placeholder('Reason for deduction')
                            ->maxLength(255),
                    ])
                    ->action(function (User $record, array $data): void {
                        if ($data['amount'] > (float) $record->wallet_amount) {
                            Notification::make()
                                ->danger()
                                ->title('Insufficient Balance')
                                ->body("Customer only has Rs {$record->wallet_amount} in wallet.")
                                ->send();
                            return;
                        }

                        $record->decrement('wallet_amount', $data['amount']);

                        WalletTransaction::recordDebit(
                            $record->id,
                            $data['amount'],
                            'admin_deduct',
                            note: $data['note'] ?? null,
                        );

                        Notification::make()
                            ->success()
                            ->title('Wallet Deducted')
                            ->body("Rs {$data['amount']} deducted from {$record->full_name}'s wallet. New balance: Rs {$record->fresh()->wallet_amount}")
                            ->send();
                    })
                    ->requiresConfirmation()
                    ->modalHeading(fn (User $record) => "Deduct: {$record->full_name}"),
            ])
            ->bulkActions([])
            ->defaultSort('id', 'desc');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Infolists\Components\Section::make('Profile')
                    ->schema([
                        Infolists\Components\TextEntry::make('full_name')
                            ->label('Full Name'),

                        Infolists\Components\TextEntry::make('email'),

                        Infolists\Components\TextEntry::make('identity')
                            ->label('Phone'),

                        Infolists\Components\TextEntry::make('role')
                            ->badge()
                            ->color(fn (string $state): string => match ($state) {
                                'rider' => 'warning',
                                default => 'info',
                            }),

                        Infolists\Components\TextEntry::make('date_of_birth')
                            ->label('Date of Birth')
                            ->date('M d, Y')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('created_at')
                            ->label('Joined')
                            ->dateTime('M d, Y H:i'),
                    ])
                    ->columns(3),

                Infolists\Components\Section::make('Wallet & Activity')
                    ->schema([
                        Infolists\Components\TextEntry::make('wallet_amount')
                            ->label('Wallet Balance')
                            ->money('PKR'),

                        Infolists\Components\TextEntry::make('addresses_count')
                            ->label('Saved Addresses')
                            ->state(fn (User $record): int => $record->addresses()->count()),

                        Infolists\Components\TextEntry::make('orders_count')
                            ->label('Total Orders')
                            ->state(fn (User $record): int => $record->orders()->count()),

                        Infolists\Components\TextEntry::make('total_spent')
                            ->label('Total Spent')
                            ->state(fn (User $record): string => 'Rs ' . number_format((float) $record->orders()->where('status', 'delivered')->sum('total_amount'), 2)),

                        Infolists\Components\TextEntry::make('complaints_count')
                            ->label('Complaints')
                            ->state(fn (User $record): int => $record->complaints()->count()),

                        Infolists\Components\TextEntry::make('last_order_at')
                            ->label('Last Order')
                            ->state(fn (User $record): ?string => $record->orders()->latest()->first()?->created_at?->format('M d, Y H:i'))
                            ->placeholder('No orders yet'),
                    ])
                    ->columns(3),

                Infolists\Components\Section::make('Order History')
                    ->schema([
                        Infolists\Components\ViewEntry::make('orders_table')
                            ->label('')
                            ->view('filament.infolists.customer-orders'),
                    ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\AddressesRelationManager::class,
            RelationManagers\OrdersRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCustomers::route('/'),
            'view' => Pages\ViewCustomer::route('/{record}'),
        ];
    }
}
