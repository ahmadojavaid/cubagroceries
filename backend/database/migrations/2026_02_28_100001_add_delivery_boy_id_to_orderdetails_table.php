<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->foreignId('delivery_boy_id')
                ->nullable()
                ->after('total_amount')
                ->constrained('deliveryboy')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->dropConstrainedForeignId('delivery_boy_id');
        });
    }
};
