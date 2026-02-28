<?php

namespace Database\Seeders;

use App\Models\Survey;
use App\Models\SurveyQuestion;
use Illuminate\Database\Seeder;

class SurveySeeder extends Seeder
{
    public function run(): void
    {
        // Survey 1: Customer Satisfaction
        $s1 = Survey::create([
            'title' => 'How are we doing?',
            'description' => 'Help us improve your shopping experience — takes under a minute!',
            'is_active' => true,
            'sort_order' => 1,
            'starts_at' => now(),
            'ends_at' => now()->addMonths(3),
        ]);

        SurveyQuestion::create([
            'survey_id' => $s1->id,
            'question' => 'How would you rate your overall experience with Cuba Groceries?',
            'type' => 'single_choice',
            'options' => ['Excellent', 'Good', 'Average', 'Poor'],
            'is_required' => true,
            'sort_order' => 1,
        ]);

        SurveyQuestion::create([
            'survey_id' => $s1->id,
            'question' => 'Which features do you use the most?',
            'type' => 'multi_choice',
            'options' => ['Browse Categories', 'Search', 'Quick Add to Cart', 'Order Tracking', 'Wallet'],
            'is_required' => true,
            'sort_order' => 2,
        ]);

        SurveyQuestion::create([
            'survey_id' => $s1->id,
            'question' => 'What could we improve?',
            'type' => 'text',
            'options' => null,
            'is_required' => false,
            'sort_order' => 3,
        ]);

        // Survey 2: Delivery Feedback (inactive — for admin to activate later)
        $s2 = Survey::create([
            'title' => 'Delivery Experience',
            'description' => 'Quick 2-question survey about our delivery service.',
            'is_active' => false,
            'sort_order' => 2,
            'starts_at' => null,
            'ends_at' => null,
        ]);

        SurveyQuestion::create([
            'survey_id' => $s2->id,
            'question' => 'How satisfied are you with delivery speed?',
            'type' => 'single_choice',
            'options' => ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
            'is_required' => true,
            'sort_order' => 1,
        ]);

        SurveyQuestion::create([
            'survey_id' => $s2->id,
            'question' => 'Were your items in good condition on arrival?',
            'type' => 'single_choice',
            'options' => ['Yes, perfect', 'Mostly fine', 'Some issues', 'No, damaged'],
            'is_required' => true,
            'sort_order' => 2,
        ]);
    }
}
