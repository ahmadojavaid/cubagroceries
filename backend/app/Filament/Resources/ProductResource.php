<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProductResource\Pages;
use App\Models\Category;
use App\Models\Product;
use App\Models\Unit;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class ProductResource extends Resource
{
    protected static ?string $model = Product::class;

    protected static ?string $navigationIcon = 'heroicon-o-cube';

    protected static ?string $navigationGroup = 'Catalog';

    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Product Details')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('e.g., Fresh Tomatoes'),

                        Forms\Components\TextInput::make('stock')
                            ->numeric()
                            ->required()
                            ->default(0)
                            ->minValue(0)
                            ->placeholder('0'),

                        Forms\Components\Select::make('category_id')
                            ->label('Category')
                            ->options(
                                Category::whereNull('parent_id')
                                    ->pluck('title', 'id')
                            )
                            ->required()
                            ->searchable()
                            ->preload()
                            ->live()
                            ->afterStateUpdated(fn (Set $set) => $set('sub_category_id', null)),

                        Forms\Components\Select::make('sub_category_id')
                            ->label('Sub-category')
                            ->options(function (Get $get) {
                                $categoryId = $get('category_id');
                                if (! $categoryId) {
                                    return [];
                                }

                                return Category::where('parent_id', $categoryId)
                                    ->pluck('title', 'id');
                            })
                            ->searchable()
                            ->preload()
                            ->placeholder('None'),

                        Forms\Components\Textarea::make('description')
                            ->rows(3)
                            ->columnSpanFull()
                            ->placeholder('Product description...'),

                        Forms\Components\FileUpload::make('image')
                            ->image()
                            ->disk('public')
                            ->directory('products')
                            ->imageResizeMode('cover')
                            ->imageCropAspectRatio('1:1')
                            ->imageResizeTargetWidth('600')
                            ->imageResizeTargetHeight('600')
                            ->columnSpanFull(),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Pricing')
                    ->description('Add one or more price-unit combinations for this product.')
                    ->schema([
                        Forms\Components\Repeater::make('prices')
                            ->relationship()
                            ->schema([
                                Forms\Components\Select::make('unit_id')
                                    ->label('Unit')
                                    ->options(Unit::pluck('name', 'id'))
                                    ->required()
                                    ->searchable()
                                    ->preload(),

                                Forms\Components\TextInput::make('price')
                                    ->required()
                                    ->numeric()
                                    ->prefix('Rs')
                                    ->minValue(0.01)
                                    ->placeholder('0.00'),
                            ])
                            ->columns(2)
                            ->minItems(1)
                            ->defaultItems(1)
                            ->addActionLabel('Add price variant')
                            ->reorderable(false)
                            ->columnSpanFull(),
                    ]),
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
                    ->sortable()
                    ->limit(40),

                Tables\Columns\TextColumn::make('category.title')
                    ->label('Category')
                    ->sortable(),

                Tables\Columns\TextColumn::make('subCategory.title')
                    ->label('Sub-category')
                    ->placeholder('—')
                    ->sortable(),

                Tables\Columns\TextColumn::make('stock')
                    ->sortable()
                    ->badge()
                    ->color(fn (int $state): string => match (true) {
                        $state <= 0 => 'danger',
                        $state <= 10 => 'warning',
                        default => 'success',
                    }),

                Tables\Columns\TextColumn::make('prices_count')
                    ->label('Prices')
                    ->counts('prices')
                    ->sortable(),

                Tables\Columns\TextColumn::make('prices_summary')
                    ->label('Price Range')
                    ->state(function (Product $record): string {
                        $prices = $record->prices->sortBy('price');
                        if ($prices->isEmpty()) {
                            return '—';
                        }
                        if ($prices->count() === 1) {
                            return 'Rs ' . number_format($prices->first()->price, 2);
                        }

                        return 'Rs ' . number_format($prices->first()->price, 2)
                            . ' – ' . number_format($prices->last()->price, 2);
                    }),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('category_id')
                    ->label('Category')
                    ->options(
                        Category::whereNull('parent_id')
                            ->pluck('title', 'id')
                    ),

                Tables\Filters\Filter::make('out_of_stock')
                    ->query(fn (Builder $query) => $query->where('stock', '<=', 0))
                    ->label('Out of Stock'),
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
            ->defaultSort('id', 'desc');
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['category', 'subCategory', 'prices']);
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
            'index' => Pages\ListProducts::route('/'),
            'create' => Pages\CreateProduct::route('/create'),
            'edit' => Pages\EditProduct::route('/{record}/edit'),
        ];
    }
}
