<?php

namespace App\Filament\Resources;

use App\Enums\OrderStatus;
use App\Filament\Resources\OrderResource\Pages;
use App\Models\DeliveryBoy;
use App\Models\Order;
use App\Models\Orderproduct;
use App\Models\OrderStatusHistory;
use App\Models\Price;
use App\Models\Product;
use App\Notifications\OrderStatusChanged;
use App\Notifications\RiderJobAssigned;
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

                        $oldStatus = $record->status;
                        $record->update(['status' => $newStatus]);

                        // Record status history
                        OrderStatusHistory::record(
                            $record->id,
                            $oldStatus->value,
                            $newStatus->value,
                            auth('portal')->user()?->name ?? 'admin',
                        );

                        // Send database notification to customer
                        $record->user->notify(new OrderStatusChanged($record, $oldStatus, $newStatus));

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
                        Forms\Components\TextInput::make('est_delivery_minutes')
                            ->label('Est. Delivery Time (minutes)')
                            ->helperText('Leave empty or 0 to hide the timer from the customer.')
                            ->numeric()
                            ->minValue(0)
                            ->maxValue(999)
                            ->suffix('min'),
                    ])
                    ->fillForm(fn (Order $record) => [
                        'delivery_boy_id' => $record->delivery_boy_id,
                        'est_delivery_minutes' => $record->est_delivery_minutes,
                    ])
                    ->action(function (Order $record, array $data): void {
                        $estMinutes = (int) ($data['est_delivery_minutes'] ?? 0);
                        $record->update([
                            'delivery_boy_id' => $data['delivery_boy_id'],
                            'est_delivery_minutes' => $estMinutes > 0 ? $estMinutes : null,
                            'est_delivery_set_at' => $estMinutes > 0 ? now() : null,
                        ]);

                        $deliveryBoy = DeliveryBoy::find($data['delivery_boy_id']);

                        // Send push notification to rider's linked user account
                        if ($deliveryBoy->user) {
                            $record->load(['user', 'address']);
                            $deliveryBoy->user->notify(new RiderJobAssigned($record));
                        }

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

                        Infolists\Components\TextEntry::make('address.phone')
                            ->label('Contact Phone')
                            ->placeholder('—'),

                        Infolists\Components\TextEntry::make('address.address')
                            ->label('Address')
                            ->columnSpan(2),

                        Infolists\Components\TextEntry::make('address.city')
                            ->label('City')
                            ->placeholder('—'),
                    ])
                    ->columns(3)
                    ->headerActions([
                        Infolists\Components\Actions\Action::make('showLocation')
                            ->label('Show Location')
                            ->icon('heroicon-o-map-pin')
                            ->color('info')
                            ->url(fn ($record) => $record->address?->latitude && $record->address?->longitude
                                ? 'https://www.google.com/maps?q=' . $record->address->latitude . ',' . $record->address->longitude
                                : null)
                            ->openUrlInNewTab()
                            ->visible(fn ($record) => $record->address?->latitude && $record->address?->longitude),
                    ]),

                Infolists\Components\Section::make('Order Items')
                    ->schema([
                        Infolists\Components\ViewEntry::make('order_items_table')
                            ->label('')
                            ->view('filament.infolists.order-items-editable'),
                    ])
                    ->headerActions([
                        Infolists\Components\Actions\Action::make('addItem')
                            ->label('Add Item')
                            ->icon('heroicon-o-plus')
                            ->color('success')
                            ->visible(fn ($record) => !$record->status->isFinal())
                            ->form([
                                Forms\Components\Select::make('product_id')
                                    ->label('Product')
                                    ->searchable()
                                    ->getSearchResultsUsing(function (string $search) {
                                        return Product::where('name', 'ilike', "%{$search}%")
                                            ->where('stock', '>', 0)
                                            ->limit(20)
                                            ->pluck('name', 'id');
                                    })
                                    ->getOptionLabelUsing(fn ($value) => Product::find($value)?->name)
                                    ->required()
                                    ->live(),
                                Forms\Components\Select::make('price_id')
                                    ->label('Unit & Price')
                                    ->options(function (Forms\Get $get) {
                                        $productId = $get('product_id');
                                        if (!$productId) return [];
                                        return Price::where('product_id', $productId)
                                            ->with('unit')
                                            ->get()
                                            ->mapWithKeys(fn ($p) => [
                                                $p->id => $p->unit->name . ' — Rs ' . number_format($p->price, 0),
                                            ]);
                                    })
                                    ->required()
                                    ->live(),
                                Forms\Components\TextInput::make('quantity')
                                    ->numeric()
                                    ->minValue(1)
                                    ->default(1)
                                    ->required(),
                            ])
                            ->action(function (Order $record, array $data): void {
                                $price = Price::with('unit')->findOrFail($data['price_id']);

                                Orderproduct::create([
                                    'order_id' => $record->id,
                                    'product_id' => $data['product_id'],
                                    'unit_id' => $price->unit_id,
                                    'quantity' => $data['quantity'],
                                    'price' => $price->price,
                                ]);

                                // Deduct stock
                                Product::where('id', $data['product_id'])
                                    ->decrement('stock', $data['quantity']);

                                // Recalculate total
                                self::recalculateOrderTotal($record);

                                Notification::make()
                                    ->success()
                                    ->title('Item Added')
                                    ->body($price->product?->name ?? 'Product' . ' added to order.')
                                    ->send();
                            })
                            ->modalHeading('Add Item to Order'),
                    ]),

                Infolists\Components\Section::make('Fulfilment Trail')
                    ->schema([
                        Infolists\Components\ViewEntry::make('fulfilment_trail')
                            ->label('')
                            ->view('filament.infolists.order-fulfilment-trail'),
                    ]),
            ]);
    }

    /**
     * Recalculate order total from its line items.
     */
    public static function recalculateOrderTotal(Order $order): void
    {
        $order->load('products');
        $newTotal = $order->products->sum(fn ($item) => $item->price * $item->quantity);
        $order->update(['total_amount' => $newTotal]);
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
