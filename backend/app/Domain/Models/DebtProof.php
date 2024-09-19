<?php

namespace App\Domain\Models;
use Illuminate\Database\Eloquent\Model;

class DebtProof extends Model
{
    protected $table = 'debt_proofs';
    protected $fillable = [
        'src',
        'type',
        'debt_id'
    ];

    public function debt() 
    {
        return $this->belongsTo('debts');
    }
}