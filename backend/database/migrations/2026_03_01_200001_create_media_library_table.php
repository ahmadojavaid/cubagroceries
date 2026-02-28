<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('media_library', function (Blueprint $table) {
            $table->id();
            $table->string('filename');           // stored filename
            $table->string('original_name');      // original upload name
            $table->string('disk')->default('public');
            $table->string('path');               // relative path in storage
            $table->string('mime_type')->nullable();
            $table->unsignedBigInteger('size')->default(0); // bytes
            $table->string('alt')->nullable();    // alt text / label
            $table->string('folder')->nullable(); // optional folder grouping
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('media_library');
    }
};
