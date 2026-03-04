<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->unsignedSmallInteger('est_delivery_minutes')->nullable()->after('delivery_boy_id');
            $table->timestamp('est_delivery_set_at')->nullable()->after('est_delivery_minutes');
        });
    }

    public function down(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->dropColumn(['est_delivery_minutes', 'est_delivery_set_at']);
        });
    }
};
