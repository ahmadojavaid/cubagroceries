<?php

namespace App\Filament\Resources\OrderResource\Pages;

use App\Filament\Resources\OrderResource;
use App\Models\Orderproduct;
use App\Models\Price;
use App\Models\Product;
use Filament\Actions;
use Filament\Forms;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ViewRecord;

class ViewOrder extends ViewRecord
{
    protected static string $resource = OrderResource::class;

    protected function getHeaderActions(): array
    {
        $order = $this->record;

        if ($order->status->isFinal()) {
            return [];
        }

        return [
            Actions\Action::make('editItems')
                ->label('Edit Items')
                ->icon('heroicon-o-pencil-square')
                ->color('warning')
                ->form(function () use ($order) {
                    $items = $order->products()->with(['product:id,name', 'unit:id,name'])->get();
                    $fields = [];

                    foreach ($items as $item) {
                        $fields[] = Forms\Components\Section::make($item->product?->name ?? 'Product')
                            ->description("{$item->unit?->name} @ Rs " . number_format($item->price, 0) . ' each')
                            ->schema([
                                Forms\Components\Hidden::make("items.{$item->id}.id")
                                    ->default($item->id),
                                Forms\Components\TextInput::make("items.{$item->id}.quantity")
                                    ->label('Quantity')
                                    ->numeric()
                                    ->minValue(0)
                                    ->default($item->quantity)
                                    ->required()
                                    ->helperText('Set to 0 to remove this item'),
                            ])
                            ->compact()
                            ->columns(1);
                    }

                    return $fields;
                })
                ->action(function (array $data) use ($order): void {
                    $itemsData = $data['items'] ?? [];
                    $changes = [];

                    foreach ($itemsData as $itemId => $row) {
                        $newQty = (int) ($row['quantity'] ?? 0);
                        $orderItem = Orderproduct::with(['product:id,name,stock', 'unit:id,name'])
                            ->find($itemId);

                        if (!$orderItem) continue;

                        $oldQty = $orderItem->quantity;
                        $diff = $newQty - $oldQty;

                        if ($newQty === 0) {
                            // Remove item — restore stock
                            Product::where('id', $orderItem->product_id)
                                ->increment('stock', $oldQty);
                            $orderItem->delete();
                            $changes[] = "Removed {$orderItem->product?->name}";
                        } elseif ($diff !== 0) {
                            // Update quantity — adjust stock
                            $orderItem->update(['quantity' => $newQty]);
                            if ($diff > 0) {
                                Product::where('id', $orderItem->product_id)->decrement('stock', $diff);
                            } else {
                                Product::where('id', $orderItem->product_id)->increment('stock', abs($diff));
                            }
                            $changes[] = "{$orderItem->product?->name}: {$oldQty} → {$newQty}";
                        }
                    }

                    if (empty($changes)) {
                        Notification::make()
                            ->info()
                            ->title('No Changes')
                            ->body('No items were modified.')
                            ->send();
                        return;
                    }

                    OrderResource::recalculateOrderTotal($order);

                    Notification::make()
                        ->success()
                        ->title('Order Updated')
                        ->body(implode("\n", $changes))
                        ->send();
                })
                ->modalHeading("Edit Items: {$order->order_id}")
                ->modalDescription('Adjust quantities or set to 0 to remove an item. Stock will be adjusted automatically.')
                ->modalSubmitActionLabel('Save Changes'),
        ];
    }
}
