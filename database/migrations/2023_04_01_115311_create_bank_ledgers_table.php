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
        Schema::create('bank_ledgers', function (Blueprint $table) {
            $table->id();
            $table->string('supplier_name')->nullable();
            $table->string('payment_id');
            $table->string('product_name')->nullable();
            $table->string('paid')->nullable();
            $table->string('due')->nullable();
            $table->string('cash')->nullable();
            $table->string('bank')->nullable();
            $table->string('date')->nullable();
            $table->string('return_amount')->nullable();
            $table->string('balance')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bank_ledgers');
    }
};
