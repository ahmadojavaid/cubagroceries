<?php

namespace App\Filament\Resources\OrderReviewResource\Pages;

use App\Filament\Resources\OrderReviewResource;
use Filament\Actions;
use Filament\Resources\Pages\ManageRecords;

class ManageOrderReviews extends ManageRecords
{
    protected static string $resource = OrderReviewResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
