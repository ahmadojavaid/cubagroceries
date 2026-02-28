<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Add role to users table
        Schema::table('users', function (Blueprint $table) {
            $table->string('role', 20)->default('customer')->after('wallet_amount');
        });

        // Add user_id to deliveryboy table
        Schema::table('deliveryboy', function (Blueprint $table) {
            $table->foreignId('user_id')->nullable()->unique()->after('payment')->constrained('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('deliveryboy', function (Blueprint $table) {
            $table->dropForeign(['user_id']);
            $table->dropColumn('user_id');
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('role');
        });
    }
};
