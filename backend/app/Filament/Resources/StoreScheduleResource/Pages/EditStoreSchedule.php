<?php

namespace App\Filament\Resources\StoreScheduleResource\Pages;

use App\Filament\Resources\StoreScheduleResource;
use Filament\Resources\Pages\EditRecord;
use Filament\Actions;

class EditStoreSchedule extends EditRecord
{
    protected static string $resource = StoreScheduleResource::class;

    protected function getHeaderActions(): array
    {
        return [Actions\DeleteAction::make()];
    }
}
