<?php

namespace App\Filament\Widgets;

use App\Models\User;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class TodaysBirthdaysWidget extends BaseWidget
{
    protected static ?int $sort = 3;

    protected int|string|array $columnSpan = 'full';

    protected static ?string $heading = "🎂 Today's Birthdays";

    public function table(Table $table): Table
    {
        return $table
            ->query(
                User::query()
                    ->whereNotNull('date_of_birth')
                    ->whereMonth('date_of_birth', now()->month)
                    ->whereDay('date_of_birth', now()->day)
            )
            ->columns([
                Tables\Columns\TextColumn::make('firstname')
                    ->label('Name')
                    ->formatStateUsing(fn ($record) => $record->firstname . ' ' . $record->lastname),

                Tables\Columns\TextColumn::make('email')
                    ->label('Email'),

                Tables\Columns\TextColumn::make('identity')
                    ->label('Phone'),

                Tables\Columns\TextColumn::make('date_of_birth')
                    ->label('Born')
                    ->date('M d, Y'),
            ])
            ->paginated(false)
            ->emptyStateHeading('No birthdays today')
            ->emptyStateIcon('heroicon-o-cake');
    }
}
