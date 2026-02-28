<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('shippingcharge', function (Blueprint $table) {
            $table->decimal('min_order_amount', 10, 2)->nullable()->after('amount');
        });

        // Set minimum for the free delivery option
        \DB::table('shippingcharge')
            ->where('title', 'like', '%Free Delivery%')
            ->update(['min_order_amount' => 2000.00]);
    }

    public function down(): void
    {
        Schema::table('shippingcharge', function (Blueprint $table) {
            $table->dropColumn('min_order_amount');
        });
    }
};
