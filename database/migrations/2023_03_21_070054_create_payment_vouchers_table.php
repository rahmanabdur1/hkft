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
        Schema::create('payment_vouchers', function (Blueprint $table) {
            $table->id();
            $table->string('financialYear')->nullable();
            $table->string('basic_date')->nullable();
            $table->string('selectedPaymentType');
            $table->string('cash_bank_account')->nullable();
            $table->string('payee_name');
            $table->string('payee_tin')->nullable();
            $table->string('payee_email')->nullable();
            $table->string('payee_phone');
            $table->string('bank_cheque_no')->nullable();
            $table->string('bank_cheque_date')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_branch')->nullable();
            $table->string('receive_amount');
            $table->string('payment_id');
            $table->string('Supporting_docs')->nullable();
            $table->string('payment_details')->nullable();
  		    $table->string('product_name');
            $table->string('qty');
            $table->string('per_unit_price');
            $table->string('total_amount');
            $table->string('payment_due')->nullable();
            $table->string('selectedProject');
            $table->string('item_unit');
            $table->string('item_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_vouchers');
    }
};
