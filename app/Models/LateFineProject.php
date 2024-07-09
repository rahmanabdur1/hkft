<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\LateFine;
class LateFineProject extends Model
{
    use HasFactory;
    protected $fillable=['project_name'];

    public function latefine(){
        return $this->belongsTo(LateFine::class,'late_fines_id');
    }
}
