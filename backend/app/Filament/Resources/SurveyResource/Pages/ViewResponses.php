<?php

namespace App\Filament\Resources\SurveyResource\Pages;

use App\Filament\Resources\SurveyResource;
use App\Models\Survey;
use App\Models\SurveyResponse;
use Filament\Resources\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Concerns\InteractsWithTable;
use Filament\Tables\Contracts\HasTable;

class ViewResponses extends Page implements HasTable
{
    use InteractsWithTable;

    protected static string $resource = SurveyResource::class;

    protected static string $view = 'filament.resources.survey-resource.pages.view-responses';

    public Survey $survey;
    public array $stats = [];
    public array $questionBreakdowns = [];

    public function mount(int $record): void
    {
        $this->survey = Survey::with('questions')->withCount('responses')->findOrFail($record);
        $this->computeStats();
    }

    public function getTitle(): string
    {
        return $this->survey->title;
    }

    public function getBreadcrumbs(): array
    {
        return [
            SurveyResource::getUrl() => 'Surveys',
            '#' => 'Responses',
            '' => $this->survey->title,
        ];
    }

    protected function computeStats(): void
    {
        $responses = SurveyResponse::where('survey_id', $this->survey->id)->get();
        $totalResponses = $responses->count();

        $this->stats = [
            'total' => $totalResponses,
            'this_week' => $responses->where('created_at', '>=', now()->startOfWeek())->count(),
            'today' => $responses->where('created_at', '>=', now()->startOfDay())->count(),
        ];

        // Build question breakdowns for choice questions
        $this->questionBreakdowns = [];
        foreach ($this->survey->questions as $question) {
            if (!in_array($question->type, ['single_choice', 'multi_choice'])) {
                continue;
            }

            $options = $question->options ?? [];
            $counts = array_fill_keys($options, 0);

            foreach ($responses as $response) {
                $answer = $response->answers[(string)$question->id] ?? null;
                if ($answer === null) continue;

                if (is_array($answer)) {
                    foreach ($answer as $opt) {
                        if (isset($counts[$opt])) $counts[$opt]++;
                    }
                } else {
                    if (isset($counts[$answer])) $counts[$answer]++;
                }
            }

            // Sort by count descending
            arsort($counts);

            $this->questionBreakdowns[] = [
                'question' => $question->question,
                'type' => $question->type,
                'total_answers' => $totalResponses,
                'options' => $counts,
            ];
        }
    }

    public function table(Table $table): Table
    {
        $questions = $this->survey->questions()->orderBy('sort_order')->get();

        $columns = [
            Tables\Columns\TextColumn::make('user.firstname')
                ->label('Customer')
                ->formatStateUsing(fn ($state, $record) =>
                    trim(($record->user->firstname ?? '') . ' ' . ($record->user->lastname ?? ''))
                )
                ->searchable(),

            Tables\Columns\TextColumn::make('created_at')
                ->label('Submitted')
                ->dateTime('M d, Y h:i A')
                ->sortable(),
        ];

        foreach ($questions as $index => $question) {
            $qId = (string)$question->id;
            $columns[] = Tables\Columns\TextColumn::make("answer_q{$qId}")
                ->label('Q' . ($index + 1))
                ->getStateUsing(function ($record) use ($qId) {
                    $answer = $record->answers[$qId] ?? null;
                    if (is_array($answer)) return implode(', ', $answer);
                    return $answer ?? '—';
                })
                ->wrap()
                ->tooltip($question->question)
                ->limit(40);
        }

        return $table
            ->query(
                SurveyResponse::query()
                    ->where('survey_id', $this->survey->id)
                    ->with('user')
            )
            ->columns($columns)
            ->defaultSort('created_at', 'desc')
            ->emptyStateHeading('No responses yet')
            ->emptyStateDescription('Responses will appear here once customers complete this survey.')
            ->emptyStateIcon('heroicon-o-clipboard-document-list')
            ->striped()
            ->paginated([10, 25, 50]);
    }
}
