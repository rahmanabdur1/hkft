<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('consume_stocks', function (Blueprint $table) {
            $table->id();
            $table->string('selectedProject')->nullable();
            $table->string('Description')->nullable();
            $table->string('consumeQuantity')->nullable();
            $table->string('product_name')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('consume_stocks');
    }
};
