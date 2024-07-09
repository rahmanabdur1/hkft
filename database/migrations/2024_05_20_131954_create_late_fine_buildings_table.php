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
        Schema::create('late_fine_buildings', function (Blueprint $table) {
            $table->id();
            $table->string('building_name')->nullable();
            $table->unsignedBigInteger('late_fines_id');
            $table->foreign('late_fines_id')->references('id')->on('late_fines')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('late_fine_buildings');
    }
};
