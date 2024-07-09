<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CashLedger extends Model
{
    use HasFactory;
    protected $fillable = ['supplier_name','payment_id','product_name','paid','due','cash','bank','date'];
}
