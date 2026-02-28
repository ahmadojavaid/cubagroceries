<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orderproduct', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained('orderdetails')->cascadeOnDelete();
            $table->foreignId('product_id')->constrained('product')->cascadeOnDelete();
            $table->foreignId('unit_id')->constrained('unit')->cascadeOnDelete();
            $table->integer('quantity');
            $table->decimal('price', 10, 2); // Price at time of order
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('orderproduct');
    }
};
