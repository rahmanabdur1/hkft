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
        Schema::create('receipt_vouchers', function (Blueprint $table) {
            $table->id();
            $table->string('financialYear')->nullable();
            $table->string('basic_date')->nullable();
            $table->string('selectedPaymentType');
            $table->string('cash_bank_account')->nullable();
            $table->string('client_name');
            $table->string('selectedProject');
            $table->string('client_tin')->nullable();
            $table->string('client_email')->nullable();
            $table->string('client_phone');
            $table->string('product_name');
            $table->string('bank_cheque_no')->nullable();
            $table->string('bank_cheque_date')->nullable();
            $table->string('bank_name')->nullable();
            $table->string('bank_branch')->nullable();
            $table->string('total_amount');
            $table->string('receipt_id');
            $table->string('Supporting_docs')->nullable();
            $table->string('payto')->nullable();
            $table->string('payees_account_no')->nullable();
  	        $table->string('payment_receipt_details')->nullable();
 	        $table->string('client_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('receipt_vouchers');
    }
};
