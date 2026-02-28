<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Survey;
use App\Models\SurveyResponse;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SurveyController extends Controller
{
    use ApiResponse;

    /**
     * GET /api/v1/surveys
     * Returns active, current surveys the user hasn't completed yet.
     * Only returns survey summary (no questions) for the home card.
     */
    public function index(Request $request): JsonResponse
    {
        $userId = $request->user()->id;

        $surveys = Survey::active()
            ->current()
            ->whereDoesntHave('responses', fn ($q) => $q->where('user_id', $userId))
            ->withCount('questions')
            ->orderBy('sort_order')
            ->get(['id', 'title', 'description', 'ends_at']);

        $formatted = $surveys->map(fn ($s) => [
            'id' => $s->id,
            'title' => $s->title,
            'description' => $s->description,
            'questions_count' => $s->questions_count,
            'ends_at' => $s->ends_at?->toIso8601String(),
        ])->values();

        return $this->success($formatted);
    }

    /**
     * GET /api/v1/surveys/{id}
     * Returns full survey detail with all questions for the survey screen.
     */
    public function show(Request $request, int $id): JsonResponse
    {
        $survey = Survey::active()
            ->current()
            ->with(['questions' => fn ($q) => $q->orderBy('sort_order')])
            ->findOrFail($id);

        // Check if already responded
        $alreadyDone = SurveyResponse::where('survey_id', $id)
            ->where('user_id', $request->user()->id)
            ->exists();

        if ($alreadyDone) {
            return $this->error('You have already completed this survey.', 422);
        }

        return $this->success([
            'id' => $survey->id,
            'title' => $survey->title,
            'description' => $survey->description,
            'questions' => $survey->questions->map(fn ($q) => [
                'id' => $q->id,
                'question' => $q->question,
                'type' => $q->type,
                'options' => $q->options,
                'is_required' => $q->is_required,
            ])->values(),
        ]);
    }

    /**
     * POST /api/v1/surveys/{id}/respond
     * Submit all answers for a survey at once.
     * Body: { "answers": { "1": "Option A", "2": ["Option B", "Option C"], "3": "Free text" } }
     */
    public function respond(Request $request, int $id): JsonResponse
    {
        $request->validate([
            'answers' => 'required|array',
        ]);

        $survey = Survey::active()->current()->with('questions')->findOrFail($id);
        $userId = $request->user()->id;

        // Prevent duplicate
        $exists = SurveyResponse::where('survey_id', $id)
            ->where('user_id', $userId)
            ->exists();

        if ($exists) {
            return $this->error('You have already completed this survey.', 422);
        }

        // Validate required questions are answered
        $answers = $request->input('answers');
        foreach ($survey->questions as $question) {
            if ($question->is_required) {
                $answer = $answers[(string)$question->id] ?? null;
                if (empty($answer)) {
                    return $this->error("Question \"{$question->question}\" is required.", 422);
                }
            }
        }

        SurveyResponse::create([
            'survey_id' => $id,
            'user_id' => $userId,
            'answers' => $answers,
        ]);

        return $this->success(null, 'Thank you for completing the survey!');
    }
}
