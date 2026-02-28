<?php

namespace App\Filament\Resources\StoreScheduleResource\Pages;

use App\Filament\Resources\StoreScheduleResource;
use Filament\Resources\Pages\ListRecords;
use Filament\Actions;

class ListStoreSchedules extends ListRecords
{
    protected static string $resource = StoreScheduleResource::class;

    protected function getHeaderActions(): array
    {
        return [Actions\CreateAction::make()];
    }
}
