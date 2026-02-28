<?php

namespace App\Filament\Resources\ShippingChargeResource\Pages;

use App\Filament\Resources\ShippingChargeResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditShippingCharge extends EditRecord
{
    protected static string $resource = ShippingChargeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
