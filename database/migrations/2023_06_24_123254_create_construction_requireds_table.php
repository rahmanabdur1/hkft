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
        Schema::create('construction_requireds', function (Blueprint $table) {
            $table->id();
            $table->string('basic_date')->nullable();
            $table->string('client_name')->nullable();
            $table->string('client_id')->nullable();
            $table->string('selectedProject')->nullable();
            $table->string('selectedBuilding')->nullable();
            $table->string('required_amount')->nullable();
            $table->string('paid_amount')->nullable();
            $table->string('extra_amount')->nullable();
            $table->string('due_amount')->nullable();
            $table->string('note')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('construction_requireds');
    }
};
