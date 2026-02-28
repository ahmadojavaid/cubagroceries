<?php
namespace App\Filament\Resources\SurveyResource\Pages;
use App\Filament\Resources\SurveyResource;
use Filament\Resources\Pages\EditRecord;
use Filament\Actions;
class EditSurvey extends EditRecord
{
    protected static string $resource = SurveyResource::class;
    protected function getHeaderActions(): array { return [Actions\DeleteAction::make()]; }
}
