<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ComplaintResource\Pages;
use App\Models\Complaint;
use Filament\Forms;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class ComplaintResource extends Resource
{
    protected static ?string $model = Complaint::class;

    protected static ?string $navigationIcon = 'heroicon-o-chat-bubble-left-ellipsis';

    protected static ?string $navigationGroup = 'Support';

    protected static ?int $navigationSort = 1;

    protected static ?string $recordTitleAttribute = 'subject';

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

                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($record) => $record->user->firstname . ' ' . $record->user->lastname)
                    ->searchable(['firstname', 'lastname']),

                Tables\Columns\TextColumn::make('order.order_id')
                    ->label('Order #')
                    ->placeholder('—')
                    ->url(fn ($record) => $record->order_id
                        ? OrderResource::getUrl('view', ['record' => $record->order_id])
                        : null),

                Tables\Columns\TextColumn::make('subject')
                    ->searchable()
                    ->limit(40),

                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'pending' => 'warning',
                        'in_progress' => 'info',
                        'resolved' => 'success',
                        'closed' => 'gray',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y H:i')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        'pending' => 'Pending',
                        'in_progress' => 'In Progress',
                        'resolved' => 'Resolved',
                        'closed' => 'Closed',
                    ]),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),

                Tables\Actions\Action::make('changeStatus')
                    ->label('Status')
                    ->icon('heroicon-o-arrow-path')
                    ->form([
                        Forms\Components\Select::make('status')
                            ->options([
                                'pending' => 'Pending',
                                'in_progress' => 'In Progress',
                                'resolved' => 'Resolved',
                                'closed' => 'Closed',
                            ])
                            ->required(),
                    ])
                    ->fillForm(fn (Complaint $record) => ['status' => $record->status])
                    ->action(function (Complaint $record, array $data): void {
                        $record->update(['status' => $data['status']]);

                        Notification::make()
                            ->success()
                            ->title('Status Updated')
                            ->body("Complaint #{$record->id} is now " . ucfirst(str_replace('_', ' ', $data['status'])) . '.')
                            ->send();
                    })
                    ->requiresConfirmation(),
            ])
            ->bulkActions([])
            ->defaultSort('created_at', 'desc');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Infolists\Components\Section::make('Complaint Details')
                    ->schema([
                        Infolists\Components\TextEntry::make('id')
                            ->label('Complaint ID'),

                        Infolists\Components\TextEntry::make('subject'),

                        Infolists\Components\TextEntry::make('status')
                            ->badge()
                            ->color(fn (string $state): string => match ($state) {
                                'pending' => 'warning',
                                'in_progress' => 'info',
                                'resolved' => 'success',
                                'closed' => 'gray',
                                default => 'gray',
                            }),

                        Infolists\Components\TextEntry::make('created_at')
                            ->label('Submitted')
                            ->dateTime('M d, Y H:i'),
                    ])
                    ->columns(4),

                Infolists\Components\Section::make('Message')
                    ->schema([
                        Infolists\Components\TextEntry::make('message')
                            ->label('')
                            ->columnSpanFull(),
                    ]),

                Infolists\Components\Section::make('Customer')
                    ->schema([
                        Infolists\Components\TextEntry::make('user.firstname')
                            ->label('Name')
                            ->formatStateUsing(fn ($record) => $record->user->firstname . ' ' . $record->user->lastname),

                        Infolists\Components\TextEntry::make('user.email')
                            ->label('Email'),

                        Infolists\Components\TextEntry::make('user.identity')
                            ->label('Phone'),
                    ])
                    ->columns(3),

                Infolists\Components\Section::make('Linked Order')
                    ->schema([
                        Infolists\Components\TextEntry::make('order.order_id')
                            ->label('Order #')
                            ->placeholder('No order linked')
                            ->url(fn ($record) => $record->order_id
                                ? OrderResource::getUrl('view', ['record' => $record->order_id])
                                : null),

                        Infolists\Components\TextEntry::make('order.status')
                            ->label('Order Status')
                            ->placeholder('—')
                            ->badge()
                            ->color(fn ($state): string => match ($state) {
                                'pending' => 'warning',
                                'confirmed' => 'info',
                                'dispatched' => 'primary',
                                'delivered' => 'success',
                                'cancelled' => 'danger',
                                default => 'gray',
                            }),

                        Infolists\Components\TextEntry::make('order.total_amount')
                            ->label('Order Total')
                            ->placeholder('—')
                            ->money('PKR'),
                    ])
                    ->columns(3)
                    ->visible(fn ($record) => $record->order_id !== null),
            ]);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListComplaints::route('/'),
            'view' => Pages\ViewComplaint::route('/{record}'),
        ];
    }
}
