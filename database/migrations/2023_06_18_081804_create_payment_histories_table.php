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
        Schema::create('payment_histories', function (Blueprint $table) {
            $table->id();
            $table->string('financialYear')->nullable();
            $table->string('basic_date')->nullable();
            $table->string('selectedPaymentType')->nullable();
            $table->string('cash_bank_account')->nullable();
            $table->string('supplier_name')->nullable();
            $table->string('product_name')->nullable();
            $table->string('bank_cheque_no')->nullable();
            $table->string('bank_cheque_date')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_branch')->nullable();
            $table->string('receive_amount')->nullable();
            $table->string('payment_id');
            $table->string('paid')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_histories');
    }
};
