<?php

namespace App\Filament\Resources;

use App\Enums\OrderStatus;
use App\Filament\Resources\OrderResource\Pages;
use App\Models\DeliveryBoy;
use App\Models\Order;
use Filament\Forms;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class OrderResource extends Resource
{
    protected static ?string $model = Order::class;

    protected static ?string $navigationIcon = 'heroicon-o-shopping-bag';

    protected static ?string $navigationGroup = 'Orders';

    protected static ?int $navigationSort = 1;

    protected static ?string $recordTitleAttribute = 'order_id';

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

                Tables\Columns\TextColumn::make('order_id')
                    ->label('Order #')
                    ->searchable()
                    ->sortable()
                    ->copyable(),

                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($record) => $record->user->firstname . ' ' . $record->user->lastname)
                    ->searchable(['firstname', 'lastname']),

                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn (OrderStatus $state): string => $state->color()),

                Tables\Columns\TextColumn::make('total_amount')
                    ->label('Total')
                    ->money('PKR')
                    ->sortable(),

                Tables\Columns\TextColumn::make('deliveryBoy.name')
                    ->label('Delivery Boy')
                    ->placeholder('—')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('products_count')
                    ->label('Items')
                    ->counts('products')
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Placed At')
                    ->dateTime('M d, Y H:i')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options(OrderStatus::options()),

                Tables\Filters\SelectFilter::make('delivery_boy_id')
                    ->label('Delivery Boy')
                    ->relationship('deliveryBoy', 'name')
                    ->preload(),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),

                Tables\Actions\Action::make('changeStatus')
                    ->label('Status')
                    ->icon('heroicon-o-arrow-path')
                    ->hidden(fn (Order $record): bool => $record->status->isFinal())
                    ->form(fn (Order $record) => [
                        Forms\Components\Select::make('status')
                            ->label('New Status')
                            ->options($record->status->allowedTransitionOptions())
                            ->required(),
                    ])
                    ->action(function (Order $record, array $data): void {
                        $newStatus = OrderStatus::from($data['status']);

                        if (! $record->status->canTransitionTo($newStatus)) {
                            Notification::make()
                                ->danger()
                                ->title('Invalid Transition')
                                ->body("Cannot change from {$record->status->label()} to {$newStatus->label()}.")
                                ->send();
                            return;
                        }

                        $record->update(['status' => $newStatus]);

                        Notification::make()
                            ->success()
                            ->title('Status Updated')
                            ->body("Order {$record->order_id} is now {$newStatus->label()}.")
                            ->send();
                    })
                    ->requiresConfirmation()
                    ->modalHeading(fn (Order $record) => "Change Status: {$record->order_id}"),

                Tables\Actions\Action::make('assignDeliveryBoy')
                    ->label('Assign Rider')
                    ->icon('heroicon-o-user-plus')
                    ->visible(fn (Order $record): bool => in_array($record->status, [
                        OrderStatus::Confirmed,
                        OrderStatus::Dispatched,
                    ]))
                    ->form([
                        Forms\Components\Select::make('delivery_boy_id')
                            ->label('Delivery Boy')
                            ->options(DeliveryBoy::pluck('name', 'id'))
                            ->searchable()
                            ->required(),
                    ])
                    ->fillForm(fn (Order $record) => [
                        'delivery_boy_id' => $record->delivery_boy_id,
                    ])
                    ->action(function (Order $record, array $data): void {
                        $record->update(['delivery_boy_id' => $data['delivery_boy_id']]);

                        $deliveryBoy = DeliveryBoy::find($data['delivery_boy_id']);

                        Notification::make()
                            ->success()
                            ->title('Delivery Boy Assigned')
                            ->body("{$deliveryBoy->name} assigned to order {$record->order_id}.")
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
                Infolists\Components\Section::make('Order Information')
                    ->schema([
                        Infolists\Components\TextEntry::make('order_id')
                            ->label('Order #')
                            ->copyable(),

                        Infolists\Components\TextEntry::make('status')
                            ->badge()
                            ->color(fn (OrderStatus $state): string => $state->color()),

                        Infolists\Components\TextEntry::make('total_amount')
                            ->label('Total')
                            ->money('PKR'),

                        Infolists\Components\TextEntry::make('created_at')
                            ->label('Placed At')
                            ->dateTime('M d, Y H:i'),
                    ])
                    ->columns(4),

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

                Infolists\Components\Section::make('Delivery')
                    ->schema([
                        Infolists\Components\TextEntry::make('deliveryBoy.name')
                            ->label('Delivery Boy')
                            ->placeholder('Not assigned'),

                        Infolists\Components\TextEntry::make('deliveryBoy.phone')
                            ->label('Rider Phone')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('address.address')
                            ->label('Address'),

                        Infolists\Components\TextEntry::make('address.city')
                            ->label('City')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('address.phone')
                            ->label('Contact Phone')
                            ->placeholder('—'),
                    ])
                    ->columns(3),

                Infolists\Components\Section::make('Order Items')
                    ->schema([
                        Infolists\Components\RepeatableEntry::make('products')
                            ->label('')
                            ->schema([
                                Infolists\Components\TextEntry::make('product.name')
                                    ->label('Product'),

                                Infolists\Components\TextEntry::make('unit.name')
                                    ->label('Unit'),

                                Infolists\Components\TextEntry::make('quantity')
                                    ->label('Qty'),

                                Infolists\Components\TextEntry::make('price')
                                    ->label('Price')
                                    ->money('PKR'),

                                Infolists\Components\TextEntry::make('line_total')
                                    ->label('Total')
                                    ->state(fn ($record) => number_format($record->price * $record->quantity, 2))
                                    ->prefix('PKR '),
                            ])
                            ->columns(5),
                    ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListOrders::route('/'),
            'view' => Pages\ViewOrder::route('/{record}'),
        ];
    }
}
