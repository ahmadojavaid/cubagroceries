<?php

namespace App\Filament\Widgets;

use App\Filament\Resources\ComplaintResource;
use App\Models\Complaint;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class PendingComplaintsWidget extends BaseWidget
{
    protected static ?int $sort = 5;

    protected int|string|array $columnSpan = 'full';

    protected static ?string $heading = 'Pending Complaints';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                Complaint::query()
                    ->with('user')
                    ->where('status', 'pending')
                    ->latest()
                    ->limit(5)
            )
            ->columns([
                Tables\Columns\TextColumn::make('subject')
                    ->limit(50),

                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($record) => $record->user?->firstname . ' ' . $record->user?->lastname),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Submitted')
                    ->dateTime('M d, Y H:i')
                    ->sortable(),
            ])
            ->actions([
                Tables\Actions\Action::make('view')
                    ->icon('heroicon-o-eye')
                    ->url(fn (Complaint $record) => ComplaintResource::getUrl('view', ['record' => $record])),
            ])
            ->paginated(false)
            ->emptyStateHeading('No pending complaints')
            ->emptyStateIcon('heroicon-o-check-circle')
            ->defaultSort('created_at', 'desc');
    }
}
