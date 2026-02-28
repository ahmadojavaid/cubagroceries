<?php
namespace App\Filament\Resources\SurveyResource\Pages;
use App\Filament\Resources\SurveyResource;
use Filament\Resources\Pages\ListRecords;
use Filament\Actions;
class ListSurveys extends ListRecords
{
    protected static string $resource = SurveyResource::class;
    protected function getHeaderActions(): array { return [Actions\CreateAction::make()]; }
}
