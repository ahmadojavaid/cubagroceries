<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Auto-approve all existing pending reviews
        DB::table('reviews')
            ->where('status', 'pending')
            ->update(['status' => 'approved']);
    }

    public function down(): void
    {
        // No rollback — reviews stay approved
    }
};
