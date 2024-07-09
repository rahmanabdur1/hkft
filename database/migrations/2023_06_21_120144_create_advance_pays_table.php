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
        Schema::create('advance_pays', function (Blueprint $table) {
            $table->id();
            $table->string('basic_date')->nullable();
            $table->string('client_name')->nullable();
            $table->string('client_id')->nullable();
            $table->string('selectedProject')->nullable();
            $table->string('selectedBuilding')->nullable();
            $table->string('amount')->nullable();
            $table->string('note')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('advance_pays');
    }
};
