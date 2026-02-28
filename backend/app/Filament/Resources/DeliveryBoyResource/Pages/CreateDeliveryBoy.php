<?php

namespace App\Filament\Resources\DeliveryBoyResource\Pages;

use App\Filament\Resources\DeliveryBoyResource;
use Filament\Resources\Pages\CreateRecord;

class CreateDeliveryBoy extends CreateRecord
{
    protected static string $resource = DeliveryBoyResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
