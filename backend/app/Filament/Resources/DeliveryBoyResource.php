<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DeliveryBoyResource\Pages;
use App\Models\DeliveryBoy;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class DeliveryBoyResource extends Resource
{
    protected static ?string $model = DeliveryBoy::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    protected static ?string $navigationGroup = 'Operations';

    protected static ?int $navigationSort = 2;

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $modelLabel = 'Delivery Boy';

    protected static ?string $pluralModelLabel = 'Delivery Boys';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make()
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('e.g., Ahmed Ali'),

                        Forms\Components\TextInput::make('phone')
                            ->required()
                            ->maxLength(50)
                            ->tel()
                            ->placeholder('e.g., 03001234567'),

                        Forms\Components\TextInput::make('payment')
                            ->numeric()
                            ->prefix('PKR')
                            ->default(0)
                            ->minValue(0)
                            ->step(0.01)
                            ->placeholder('0.00')
                            ->helperText('Total payment/earnings'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('phone')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('payment')
                    ->money('PKR')
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('id', 'asc');
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDeliveryBoys::route('/'),
            'create' => Pages\CreateDeliveryBoy::route('/create'),
            'edit' => Pages\EditDeliveryBoy::route('/{record}/edit'),
        ];
    }
}
