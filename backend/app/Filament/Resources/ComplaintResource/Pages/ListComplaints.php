<?php

namespace App\Filament\Resources\ComplaintResource\Pages;

use App\Filament\Resources\ComplaintResource;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Components\Tab;
use Illuminate\Database\Eloquent\Builder;

class ListComplaints extends ListRecords
{
    protected static string $resource = ComplaintResource::class;

    public function getTabs(): array
    {
        return [
            'all' => Tab::make('All'),
            'open' => Tab::make('Open')
                ->modifyQueryUsing(fn (Builder $query) =>
                    $query->whereIn('status', ['pending', 'in_progress'])),
            'closed' => Tab::make('Closed')
                ->modifyQueryUsing(fn (Builder $query) =>
                    $query->whereIn('status', ['resolved', 'closed'])),
        ];
    }
}
