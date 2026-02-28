<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Survey;
use App\Models\SurveyResponse;
use Illuminate\Http\Request;

class SurveyController extends Controller
{
    /**
     * Get active surveys the user hasn't responded to yet.
     */
    public function index(Request $request)
    {
        $userId = $request->user()->id;

        $surveys = Survey::where('is_active', true)
            ->whereDoesntHave('responses', fn ($q) => $q->where('user_id', $userId))
            ->orderBy('sort_order')
            ->get(['id', 'question', 'options']);

        return response()->json([
            'success' => true,
            'data' => $surveys,
        ]);
    }

    /**
     * Submit a response to a survey.
     */
    public function respond(Request $request, int $surveyId)
    {
        $request->validate([
            'answer' => 'required|string|max:500',
        ]);

        $survey = Survey::where('is_active', true)->findOrFail($surveyId);

        $existing = SurveyResponse::where('survey_id', $surveyId)
            ->where('user_id', $request->user()->id)
            ->first();

        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'You have already responded to this survey.',
            ], 422);
        }

        SurveyResponse::create([
            'survey_id' => $surveyId,
            'user_id' => $request->user()->id,
            'answer' => $request->answer,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Thank you for your feedback!',
        ], 201);
    }
}
