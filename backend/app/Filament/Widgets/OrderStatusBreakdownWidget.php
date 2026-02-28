<?php

namespace App\Filament\Widgets;

use App\Enums\OrderStatus;
use App\Models\Order;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class OrderStatusBreakdownWidget extends BaseWidget
{
    protected static ?int $sort = 2;

    protected static ?string $heading = 'Order Status Breakdown';

    protected function getStats(): array
    {
        $counts = Order::query()
            ->selectRaw('status, count(*) as total')
            ->groupBy('status')
            ->pluck('total', 'status');

        return collect(OrderStatus::cases())->map(function (OrderStatus $status) use ($counts) {
            return Stat::make($status->label(), $counts->get($status->value, 0))
                ->color($status->color())
                ->descriptionIcon(match ($status) {
                    OrderStatus::Pending => 'heroicon-m-clock',
                    OrderStatus::Confirmed => 'heroicon-m-check-circle',
                    OrderStatus::Dispatched => 'heroicon-m-truck',
                    OrderStatus::Delivered => 'heroicon-m-check-badge',
                    OrderStatus::Cancelled => 'heroicon-m-x-circle',
                })
                ->description(match ($status) {
                    OrderStatus::Pending => 'Awaiting confirmation',
                    OrderStatus::Confirmed => 'Confirmed by admin',
                    OrderStatus::Dispatched => 'Out for delivery',
                    OrderStatus::Delivered => 'Successfully delivered',
                    OrderStatus::Cancelled => 'Cancelled orders',
                });
        })->all();
    }
}
