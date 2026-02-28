<?php

namespace App\Filament\Resources;

use App\Filament\Resources\OrderReviewResource\Pages;
use App\Models\OrderReview;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class OrderReviewResource extends Resource
{
    protected static ?string $model = OrderReview::class;

    protected static ?string $navigationIcon = 'heroicon-o-star';

    protected static ?string $navigationGroup = 'Reviews';

    protected static ?string $navigationLabel = 'Order Reviews';

    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Select::make('user_id')
                ->relationship('user', 'firstname')
                ->disabled(),
            Forms\Components\Select::make('order_id')
                ->relationship('order', 'order_id')
                ->disabled(),
            Forms\Components\TextInput::make('rating')
                ->disabled(),
            Forms\Components\Textarea::make('comment')
                ->disabled()
                ->columnSpanFull(),
        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('order.order_id')
                    ->label('Order')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('user.firstname')
                    ->label('Customer')
                    ->formatStateUsing(fn ($state, OrderReview $record) => "{$record->user->firstname} {$record->user->lastname}")
                    ->searchable(),
                Tables\Columns\TextColumn::make('rating')
                    ->badge()
                    ->color(fn (int $state): string => match (true) {
                        $state >= 4 => 'success',
                        $state >= 3 => 'warning',
                        default => 'danger',
                    })
                    ->suffix('/5'),
                Tables\Columns\TextColumn::make('comment')
                    ->limit(60)
                    ->toggleable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y')
                    ->sortable(),
            ])
            ->defaultSort('created_at', 'desc')
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ManageOrderReviews::route('/'),
        ];
    }
}
