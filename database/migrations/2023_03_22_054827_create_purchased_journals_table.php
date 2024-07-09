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
        Schema::create('purchased_journals', function (Blueprint $table) {
            $table->id();
            $table->string('payment_id');
            $table->string('purchase_type')->nullable();
            $table->string('product_name')->nullable();
            $table->string('total_amount')->nullable();
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
        Schema::dropIfExists('purchased_journals');
    }
};
