<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AddressResource\Pages;
use App\Models\Address;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class AddressResource extends Resource
{
    public static function canAccess(): bool
    {
        return auth('portal')->user()?->isAdmin() ?? false;
    }

    protected static ?string $model = Address::class;

    protected static ?string $navigationIcon = 'heroicon-o-map-pin';

    protected static ?string $navigationGroup = 'Users';

    protected static ?int $navigationSort = 3;

    protected static ?string $modelLabel = 'Address';

    protected static ?string $pluralModelLabel = 'Addresses';

    public static function canCreate(): bool
    {
        return false;
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Infolists\Components\Section::make()
                    ->schema([
                        Infolists\Components\TextEntry::make('user.firstname')
                            ->label('Customer')
                            ->formatStateUsing(fn ($state, Address $record) =>
                                "{$record->user->firstname} {$record->user->lastname}"),

                        Infolists\Components\TextEntry::make('label')
                            ->badge()
                            ->color('info')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('address')
                            ->columnSpanFull(),

                        Infolists\Components\TextEntry::make('city')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('phone')
                            ->placeholder('—'),

                        Infolists\Components\IconEntry::make('is_default')
                            ->label('Default')
                            ->boolean(),

                        Infolists\Components\TextEntry::make('latitude')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('longitude')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('created_at')
                            ->dateTime('M d, Y H:i'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($state, Address $record) =>
                        "{$record->user->firstname} {$record->user->lastname}")
                    ->searchable(['firstname', 'lastname'])
                    ->sortable(),

                Tables\Columns\TextColumn::make('label')
                    ->badge()
                    ->color('info'),

                Tables\Columns\TextColumn::make('address')
                    ->limit(40)
                    ->searchable(),

                Tables\Columns\TextColumn::make('city')
                    ->searchable(),

                Tables\Columns\TextColumn::make('phone'),

                Tables\Columns\IconColumn::make('is_default')
                    ->label('Default')
                    ->boolean(),
            ])
            ->defaultSort('user_id', 'asc')
            ->filters([
                Tables\Filters\SelectFilter::make('city')
                    ->options(fn () => Address::distinct()->pluck('city', 'city')->filter()->toArray()),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListAddresses::route('/'),
        ];
    }
}
