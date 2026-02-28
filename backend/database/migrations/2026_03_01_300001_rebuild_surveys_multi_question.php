<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Drop old tables
        Schema::dropIfExists('survey_responses');
        Schema::dropIfExists('surveys');

        // Surveys — container with title, description, date range
        Schema::create('surveys', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamp('starts_at')->nullable();
            $table->timestamp('ends_at')->nullable();
            $table->integer('sort_order')->default(0);
            $table->timestamps();
        });

        // Survey questions — each survey has multiple questions
        Schema::create('survey_questions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('survey_id')->constrained('surveys')->cascadeOnDelete();
            $table->string('question');
            $table->string('type')->default('single_choice'); // single_choice, multi_choice, text
            $table->json('options')->nullable(); // array of option strings (for choice types)
            $table->boolean('is_required')->default(true);
            $table->integer('sort_order')->default(0);
            $table->timestamps();
        });

        // Survey responses — one row per user per survey (answers stored as JSON)
        Schema::create('survey_responses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('survey_id')->constrained('surveys')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->json('answers'); // { "question_id": "answer_value", ... }
            $table->timestamps();

            $table->unique(['survey_id', 'user_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('survey_responses');
        Schema::dropIfExists('survey_questions');
        Schema::dropIfExists('surveys');
    }
};
