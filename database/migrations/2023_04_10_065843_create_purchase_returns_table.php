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
        Schema::create('purchase_returns', function (Blueprint $table) {
            $table->id();
            $table->string('payment_id')->nullable();
            $table->string('supplier_name')->nullable();
            $table->string('per_unit_price')->nullable();
            $table->string('max_qty')->nullable();
            $table->string('return_qty')->nullable();
            $table->string('payment_due')->nullable();
            $table->string('return_amount')->nullable();
            $table->string('remaining_due')->nullable();
            $table->string('date')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_returns');
    }
};
