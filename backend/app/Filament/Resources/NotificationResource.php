<?php

namespace App\Filament\Resources;

use App\Filament\Resources\NotificationResource\Pages;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Notifications\DatabaseNotification;

class NotificationResource extends Resource
{
    protected static ?string $model = DatabaseNotification::class;

    protected static ?string $navigationIcon = 'heroicon-o-bell';

    protected static ?string $navigationGroup = 'System';

    protected static ?int $navigationSort = 1;

    protected static ?string $modelLabel = 'Notification';

    protected static ?string $pluralModelLabel = 'Notifications';

    protected static ?string $slug = 'notifications';

    public static function canCreate(): bool
    {
        return false;
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('data.title')
                    ->label('Title')
                    ->searchable()
                    ->limit(50),

                Tables\Columns\TextColumn::make('data.message')
                    ->label('Message')
                    ->limit(60),

                Tables\Columns\TextColumn::make('notifiable.firstname')
                    ->label('Customer')
                    ->formatStateUsing(function ($state, DatabaseNotification $record) {
                        $user = $record->notifiable;
                        return $user ? "{$user->firstname} {$user->lastname}" : '—';
                    }),

                Tables\Columns\TextColumn::make('read_at')
                    ->label('Status')
                    ->formatStateUsing(fn ($state) => $state ? 'Read' : 'Unread')
                    ->badge()
                    ->color(fn ($state) => $state ? 'gray' : 'warning'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Sent')
                    ->dateTime('M d, Y h:i A')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                Tables\Filters\TernaryFilter::make('read')
                    ->label('Read Status')
                    ->nullable()
                    ->trueLabel('Read')
                    ->falseLabel('Unread')
                    ->queries(
                        true: fn ($query) => $query->whereNotNull('read_at'),
                        false: fn ($query) => $query->whereNull('read_at'),
                    ),
            ])
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListNotifications::route('/'),
        ];
    }
}
