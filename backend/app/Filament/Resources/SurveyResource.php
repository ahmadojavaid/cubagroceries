<?php

namespace App\Filament\Resources;

use App\Filament\Resources\SurveyResource\Pages;
use App\Models\Survey;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class SurveyResource extends Resource
{
    protected static ?string $model = Survey::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';

    protected static ?string $navigationGroup = 'Marketing';

    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Survey Details')
                    ->schema([
                        Forms\Components\TextInput::make('title')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('e.g., Customer Satisfaction Survey')
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('description')
                            ->placeholder('Brief description shown to customers before they start...')
                            ->rows(2)
                            ->columnSpanFull(),

                        Forms\Components\DateTimePicker::make('starts_at')
                            ->label('Start Date')
                            ->helperText('Leave empty to start immediately'),

                        Forms\Components\DateTimePicker::make('ends_at')
                            ->label('End Date')
                            ->helperText('Leave empty for no expiry'),

                        Forms\Components\Toggle::make('is_active')
                            ->label('Active')
                            ->default(true)
                            ->helperText('Only active surveys are shown to customers'),

                        Forms\Components\TextInput::make('sort_order')
                            ->numeric()
                            ->default(0)
                            ->helperText('Lower numbers appear first'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Questions')
                    ->schema([
                        Forms\Components\Repeater::make('questions')
                            ->relationship()
                            ->schema([
                                Forms\Components\TextInput::make('question')
                                    ->required()
                                    ->maxLength(500)
                                    ->placeholder('Enter your question...')
                                    ->columnSpanFull(),

                                Forms\Components\Select::make('type')
                                    ->options([
                                        'single_choice' => 'Single Choice (Radio)',
                                        'multi_choice' => 'Multiple Choice (Checkbox)',
                                        'text' => 'Free Text',
                                    ])
                                    ->default('single_choice')
                                    ->required()
                                    ->live(),

                                Forms\Components\Toggle::make('is_required')
                                    ->label('Required')
                                    ->default(true),

                                Forms\Components\TagsInput::make('options')
                                    ->label('Answer Options')
                                    ->placeholder('Type an option and press Enter')
                                    ->helperText('Add each option one at a time')
                                    ->visible(fn (Forms\Get $get) => in_array($get('type'), ['single_choice', 'multi_choice']))
                                    ->columnSpanFull(),

                                Forms\Components\Hidden::make('sort_order')
                                    ->default(0),
                            ])
                            ->columns(2)
                            ->orderColumn('sort_order')
                            ->reorderable()
                            ->collapsible()
                            ->cloneable()
                            ->defaultItems(1)
                            ->addActionLabel('Add Question')
                            ->itemLabel(fn (array $state): ?string =>
                                $state['question'] ?? 'New Question'
                            ),
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

                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable()
                    ->limit(40),

                Tables\Columns\TextColumn::make('questions_count')
                    ->label('Questions')
                    ->counts('questions')
                    ->sortable(),

                Tables\Columns\TextColumn::make('responses_count')
                    ->label('Responses')
                    ->counts('responses')
                    ->sortable(),

                Tables\Columns\IconColumn::make('is_active')
                    ->label('Active')
                    ->boolean()
                    ->sortable(),

                Tables\Columns\TextColumn::make('starts_at')
                    ->label('Starts')
                    ->dateTime('M d, Y')
                    ->placeholder('Immediately')
                    ->sortable(),

                Tables\Columns\TextColumn::make('ends_at')
                    ->label('Ends')
                    ->dateTime('M d, Y')
                    ->placeholder('No expiry')
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('M d, Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->actions([
                Tables\Actions\Action::make('responses')
                    ->label('Responses')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->url(fn ($record) => static::getUrl('responses', ['record' => $record])),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('sort_order', 'asc');
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListSurveys::route('/'),
            'create' => Pages\CreateSurvey::route('/create'),
            'edit' => Pages\EditSurvey::route('/{record}/edit'),
            'responses' => Pages\ViewResponses::route('/{record}/responses'),
        ];
    }
}
