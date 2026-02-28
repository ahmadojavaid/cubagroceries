<?php

namespace App\Filament\Widgets;

use App\Enums\OrderStatus;
use App\Models\Category;
use App\Models\Order;
use App\Models\Product;
use App\Models\Review;
use App\Models\User;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Number;

class StatsOverviewWidget extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        $revenue = Order::where('status', OrderStatus::Delivered)->sum('total_amount');

        return [
            Stat::make('Total Orders', Order::count())
                ->description('All orders placed')
                ->descriptionIcon('heroicon-m-shopping-bag')
                ->color('primary'),

            Stat::make('Revenue', 'Rs ' . Number::format($revenue, 2))
                ->description('From delivered orders')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('success'),

            Stat::make("Today's Orders", Order::whereDate('created_at', today())->count())
                ->description('Orders placed today')
                ->descriptionIcon('heroicon-m-calendar')
                ->color('info'),

            Stat::make('Pending Orders', Order::where('status', OrderStatus::Pending)->count())
                ->description('Awaiting confirmation')
                ->descriptionIcon('heroicon-m-clock')
                ->color('warning'),

            Stat::make('Total Customers', User::count())
                ->description('Registered customers')
                ->descriptionIcon('heroicon-m-users')
                ->color('success'),

            Stat::make('Total Categories', Category::topLevel()->count())
                ->description('Top-level categories')
                ->descriptionIcon('heroicon-m-squares-2x2')
                ->color('info'),

            Stat::make('Total Products', Product::count())
                ->description('Products in catalog')
                ->descriptionIcon('heroicon-m-cube')
                ->color('warning'),

            Stat::make('Product Reviews', Review::where('status', 'approved')->count())
                ->description('Approved reviews')
                ->descriptionIcon('heroicon-m-star')
                ->color('success'),
        ];
    }
}
