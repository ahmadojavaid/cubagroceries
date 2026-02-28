<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CouponResource\Pages;
use App\Models\Coupon;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CouponResource extends Resource
{
    protected static ?string $model = Coupon::class;

    protected static ?string $navigationIcon = 'heroicon-o-ticket';

    protected static ?string $navigationGroup = 'Marketing';

    protected static ?int $navigationSort = 1;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Coupon Details')
                    ->schema([
                        Forms\Components\TextInput::make('code')
                            ->required()
                            ->unique(ignoreRecord: true)
                            ->maxLength(50)
                            ->helperText('Customers will enter this code at checkout'),

                        Forms\Components\TextInput::make('description')
                            ->maxLength(255)
                            ->placeholder('e.g. 10% off your first order'),

                        Forms\Components\Select::make('type')
                            ->options([
                                'fixed' => 'Fixed Amount (Rs)',
                                'percentage' => 'Percentage (%)',
                            ])
                            ->required()
                            ->default('fixed')
                            ->live(),

                        Forms\Components\TextInput::make('value')
                            ->required()
                            ->numeric()
                            ->minValue(0)
                            ->prefix(fn (Forms\Get $get) => $get('type') === 'percentage' ? '%' : 'Rs'),

                        Forms\Components\TextInput::make('min_order_amount')
                            ->label('Minimum Order Amount')
                            ->numeric()
                            ->prefix('Rs')
                            ->minValue(0)
                            ->placeholder('No minimum'),

                        Forms\Components\TextInput::make('max_discount')
                            ->label('Max Discount Cap')
                            ->numeric()
                            ->prefix('Rs')
                            ->minValue(0)
                            ->placeholder('No cap')
                            ->visible(fn (Forms\Get $get) => $get('type') === 'percentage'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Validity & Limits')
                    ->schema([
                        Forms\Components\DatePicker::make('start_date'),

                        Forms\Components\DatePicker::make('end_date')
                            ->afterOrEqual('start_date'),

                        Forms\Components\TextInput::make('usage_limit')
                            ->label('Usage Limit')
                            ->numeric()
                            ->integer()
                            ->minValue(1)
                            ->placeholder('Unlimited'),

                        Forms\Components\Toggle::make('is_active')
                            ->label('Active')
                            ->default(true),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('code')
                    ->searchable()
                    ->sortable()
                    ->weight('bold')
                    ->copyable(),

                Tables\Columns\TextColumn::make('type')
                    ->badge()
                    ->color(fn (string $state) => $state === 'percentage' ? 'info' : 'success'),

                Tables\Columns\TextColumn::make('value')
                    ->label('Discount')
                    ->formatStateUsing(function ($state, Coupon $record) {
                        return $record->type === 'percentage'
                            ? $state . '%'
                            : 'Rs ' . number_format($state, 0);
                    }),

                Tables\Columns\TextColumn::make('min_order_amount')
                    ->label('Min Order')
                    ->prefix('Rs ')
                    ->placeholder('—'),

                Tables\Columns\TextColumn::make('used_count')
                    ->label('Used')
                    ->formatStateUsing(function ($state, Coupon $record) {
                        return $record->usage_limit
                            ? "{$state} / {$record->usage_limit}"
                            : $state;
                    }),

                Tables\Columns\TextColumn::make('end_date')
                    ->label('Expires')
                    ->date('M d, Y')
                    ->placeholder('Never'),

                Tables\Columns\IconColumn::make('is_active')
                    ->label('Active')
                    ->boolean(),
            ])
            ->filters([
                Tables\Filters\TernaryFilter::make('is_active')
                    ->label('Active'),
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
            ->defaultSort('created_at', 'desc');
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCoupons::route('/'),
            'create' => Pages\CreateCoupon::route('/create'),
            'edit' => Pages\EditCoupon::route('/{record}/edit'),
        ];
    }
}
