<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_status_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained('orderdetails')->cascadeOnDelete();
            $table->string('from_status')->nullable(); // null for initial placement
            $table->string('to_status');
            $table->string('changed_by')->nullable(); // admin name, 'system', 'rider', etc.
            $table->string('note')->nullable();
            $table->timestamp('created_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_status_history');
    }
};
