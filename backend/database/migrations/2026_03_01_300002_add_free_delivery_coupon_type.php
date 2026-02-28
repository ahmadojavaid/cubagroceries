<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // PostgreSQL: alter enum type to add 'free_delivery'
        DB::statement("ALTER TABLE coupons DROP CONSTRAINT IF EXISTS coupons_type_check");
        DB::statement("ALTER TABLE coupons ALTER COLUMN type TYPE varchar(20)");
        // The enum constraint was handled by Laravel's enum() which creates a CHECK constraint
    }

    public function down(): void
    {
        // Revert free_delivery entries back to fixed before re-constraining
        DB::table('coupons')->where('type', 'free_delivery')->update(['type' => 'fixed']);
    }
};
