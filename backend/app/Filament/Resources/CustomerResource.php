<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CustomerResource\Pages;
use App\Models\User;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CustomerResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static ?string $navigationGroup = 'Customers';

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

                        Infolists\Components\TextEntry::make('date_of_birth')
                            ->label('Date of Birth')
                            ->date('M d, Y')
                            ->placeholder('—'),
                    ])
                    ->columns(2),

                Infolists\Components\Section::make('Stats')
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
                    ])
                    ->columns(3),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCustomers::route('/'),
            'view' => Pages\ViewCustomer::route('/{record}'),
        ];
    }
}
