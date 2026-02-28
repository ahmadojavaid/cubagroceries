<?php

namespace App\Filament\Resources;

use App\Filament\Resources\SearchHistoryResource\Pages;
use App\Models\SearchHistory;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class SearchHistoryResource extends Resource
{
    protected static ?string $model = SearchHistory::class;

    protected static ?string $navigationIcon = 'heroicon-o-magnifying-glass';

    protected static ?string $navigationGroup = 'Analytics';

    protected static ?int $navigationSort = 1;

    protected static ?string $modelLabel = 'Search Query';

    protected static ?string $pluralModelLabel = 'Search History';

    protected static ?string $slug = 'search-history';

    public static function canCreate(): bool
    {
        return false;
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('query')
                    ->label('Search Term')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($state, SearchHistory $record) =>
                        $record->user ? "{$record->user->firstname} {$record->user->lastname}" : 'Guest')
                    ->searchable(['firstname', 'lastname']),

                Tables\Columns\TextColumn::make('results_count')
                    ->label('Results')
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Searched At')
                    ->dateTime('M d, Y h:i A')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
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
            'index' => Pages\ListSearchHistories::route('/'),
        ];
    }
}
