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
        Schema::create('purchase_lands', function (Blueprint $table) {
            $table->id();
            $table->string('land_office')->nullable();
            $table->string('moujar')->nullable();
            $table->string('thana')->nullable();
            $table->string('district')->nullable();
            $table->string('owner_name')->nullable();
            $table->string('holding_number')->nullable();
            $table->string('land_class')->nullable();
            $table->string('ledger_no')->nullable();
            $table->string('dag_no')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_lands');
    }
};
