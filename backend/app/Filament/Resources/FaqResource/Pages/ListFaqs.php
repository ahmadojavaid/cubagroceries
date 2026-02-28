<?php
namespace App\Filament\Resources\FaqResource\Pages;
use App\Filament\Resources\FaqResource;
use Filament\Resources\Pages\ListRecords;
use Filament\Actions;

class ListFaqs extends ListRecords
{
    protected static string $resource = FaqResource::class;
    protected function getHeaderActions(): array { return [Actions\CreateAction::make()]; }
}
