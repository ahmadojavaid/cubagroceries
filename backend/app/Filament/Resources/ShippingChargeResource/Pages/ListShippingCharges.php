<?php

namespace App\Filament\Resources\ShippingChargeResource\Pages;

use App\Filament\Resources\ShippingChargeResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListShippingCharges extends ListRecords
{
    protected static string $resource = ShippingChargeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
