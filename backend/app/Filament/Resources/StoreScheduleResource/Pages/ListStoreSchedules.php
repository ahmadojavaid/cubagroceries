<?php

namespace App\Filament\Resources\StoreScheduleResource\Pages;

use App\Filament\Resources\StoreScheduleResource;
use App\Models\AppSetting;
use App\Models\StoreSchedule;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ListRecords;
use Filament\Actions;

class ListStoreSchedules extends ListRecords
{
    protected static string $resource = StoreScheduleResource::class;

    public bool $enforceSchedule = false;

    public function mount(): void
    {
        parent::mount();
        $this->enforceSchedule = AppSetting::getValue('enforce_daily_schedule', '0') === '1';
    }

    public function toggleEnforce(): void
    {
        $this->enforceSchedule = ! $this->enforceSchedule;
        AppSetting::setValue('enforce_daily_schedule', $this->enforceSchedule ? '1' : '0');

        Notification::make()
            ->title($this->enforceSchedule
                ? 'Store will now go offline outside these hours'
                : 'Daily schedule enforcement disabled')
            ->icon($this->enforceSchedule ? 'heroicon-o-check-circle' : 'heroicon-o-x-circle')
            ->color($this->enforceSchedule ? 'success' : 'warning')
            ->send();
    }

    protected function getHeaderActions(): array
    {
        return [Actions\CreateAction::make()];
    }

    protected function getHeaderWidgets(): array
    {
        return [];
    }

    public function getHeader(): ?\Illuminate\Contracts\View\View
    {
        return view('filament.resources.store-schedule.header', [
            'enforceSchedule' => $this->enforceSchedule,
            'todaySchedule' => StoreSchedule::getTodaySchedule(),
            'isOutsideHours' => StoreSchedule::isOutsideOperatingHours(),
        ]);
    }
}
