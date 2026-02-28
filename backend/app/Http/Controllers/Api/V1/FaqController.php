<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Faq;

class FaqController extends Controller
{
    public function index()
    {
        $faqs = Faq::active()->ordered()->get(['id', 'question', 'answer']);

        return response()->json([
            'success' => true,
            'data' => $faqs,
        ]);
    }
}
