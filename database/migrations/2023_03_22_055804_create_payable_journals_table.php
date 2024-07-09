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
        Schema::create('payable_journals', function (Blueprint $table) {
            $table->id();
            $table->string('payment_id');
            $table->string('payee_name')->nullable();
            $table->string('payee_name_type')->nullable();
            $table->string('due')->nullable();
            $table->string('cash')->nullable();
            $table->string('bank')->nullable();
            $table->string('cash_type')->nullable();
            $table->string('bank_type')->nullable();
            $table->string('paid')->nullable();
            $table->string('payable_date')->nullable();
            $table->string('financialYear')->nullable(); 
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payable_journals');
    }
};
