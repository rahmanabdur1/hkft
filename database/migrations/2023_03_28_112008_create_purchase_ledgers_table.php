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
        Schema::create('purchase_ledgers', function (Blueprint $table) {
            $table->id();
            $table->string('supplier_name');
            $table->string('payment_id');
            $table->string('product_name');
            $table->string('paid');
            $table->string('due');
            $table->string('cash')->nullable();
            $table->string('bank')->nullable();
            $table->string('date');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase_ledgers');
    }
};
