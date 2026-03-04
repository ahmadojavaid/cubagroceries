<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Update app_settings: Cuba Groceries -> Asif Groceries
        DB::table('app_settings')
            ->where('key', 'app_name')
            ->update(['value' => 'Asif Groceries']);

        // Also update about_us, terms, contact_email if they reference Cuba
        DB::table('app_settings')
            ->where('key', 'contact_email')
            ->where('value', 'ilike', '%cuba%')
            ->update(['value' => 'support@asifgroceries.pk']);

        DB::table('app_settings')
            ->where('key', 'about_us')
            ->where('value', 'ilike', '%cuba%')
            ->update(['value' => '<p>Asif Groceries is your trusted online grocery store in Lahore, delivering fresh produce and daily essentials to your doorstep.</p>']);

        DB::table('app_settings')
            ->where('key', 'terms_and_conditions')
            ->where('value', 'ilike', '%cuba%')
            ->update(['value' => '<p>By using Asif Groceries, you agree to our terms of service. All orders are subject to availability.</p>']);
    }

    public function down(): void
    {
        DB::table('app_settings')
            ->where('key', 'app_name')
            ->update(['value' => 'Cuba Groceries']);
    }
};
