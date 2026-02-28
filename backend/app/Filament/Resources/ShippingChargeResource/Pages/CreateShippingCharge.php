<?php

namespace App\Filament\Resources\ShippingChargeResource\Pages;

use App\Filament\Resources\ShippingChargeResource;
use Filament\Resources\Pages\CreateRecord;

class CreateShippingCharge extends CreateRecord
{
    protected static string $resource = ShippingChargeResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
