<?php

namespace App\Filament\Resources;

use App\Filament\Resources\StoreScheduleResource\Pages;
use App\Models\StoreSchedule;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class StoreScheduleResource extends Resource
{
    protected static ?string $model = StoreSchedule::class;

    protected static ?string $navigationIcon = 'heroicon-o-clock';

    protected static ?string $navigationGroup = 'Operations';

    protected static ?int $navigationSort = 3;

    protected static ?string $modelLabel = 'Store Schedule';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\Select::make('day')
                            ->options(StoreSchedule::DAYS)
                            ->required()
                            ->unique(ignoreRecord: true),

                        Forms\Components\TimePicker::make('open_time')
                            ->required()
                            ->seconds(false),

                        Forms\Components\TimePicker::make('close_time')
                            ->required()
                            ->seconds(false)
                            ->after('open_time'),

                        Forms\Components\Toggle::make('is_closed')
                            ->label('Closed for the day')
                            ->helperText('Mark this day as closed'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('day')
                    ->formatStateUsing(fn (string $state) => StoreSchedule::DAYS[$state] ?? $state)
                    ->sortable(),

                Tables\Columns\TextColumn::make('open_time')
                    ->label('Opens')
                    ->time('h:i A'),

                Tables\Columns\TextColumn::make('close_time')
                    ->label('Closes')
                    ->time('h:i A'),

                Tables\Columns\IconColumn::make('is_closed')
                    ->label('Closed?')
                    ->boolean()
                    ->trueIcon('heroicon-o-x-circle')
                    ->falseIcon('heroicon-o-check-circle')
                    ->trueColor('danger')
                    ->falseColor('success'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([])
            ->defaultSort('id', 'asc')
            ->paginated(false);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListStoreSchedules::route('/'),
            'create' => Pages\CreateStoreSchedule::route('/create'),
            'edit' => Pages\EditStoreSchedule::route('/{record}/edit'),
        ];
    }
}
