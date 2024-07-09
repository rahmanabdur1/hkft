<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\LateFineBuilding;
use App\Models\LateFineProject;
class LateFine extends Model
{
    use HasFactory;
    protected $fillable = ['amount'];
    public function project(){
        return $this->hasMany(LateFineProject::class,'late_fines_id');
    }
    public function building(){
        return $this->hasMany(LateFineBuilding::class,'late_fines_id');
    }
}
