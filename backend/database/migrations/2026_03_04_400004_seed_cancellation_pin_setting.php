<?php

use App\Models\AppSetting;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    public function up(): void
    {
        // Seed default cancellation PIN if not already set
        if (empty(AppSetting::getValue('cancellation_pin'))) {
            AppSetting::setValue('cancellation_pin', '1234');
        }
    }

    public function down(): void
    {
        // Don't remove — leave the setting in place
    }
};
