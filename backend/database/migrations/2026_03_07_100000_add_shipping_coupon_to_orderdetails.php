<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->string('shipping_title')->nullable()->after('wallet_amount_used');
            $table->decimal('shipping_amount', 10, 2)->default(0)->after('shipping_title');
            $table->string('coupon_code', 50)->nullable()->after('shipping_amount');
            $table->decimal('coupon_discount', 10, 2)->default(0)->after('coupon_code');
        });
    }

    public function down(): void
    {
        Schema::table('orderdetails', function (Blueprint $table) {
            $table->dropColumn(['shipping_title', 'shipping_amount', 'coupon_code', 'coupon_discount']);
        });
    }
};
