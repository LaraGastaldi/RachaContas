<?php

namespace App\Domain\Models;

use Carbon\Traits\Timestamp;
use Illuminate\Database\Eloquent\Model;

/**
 * Classe base do veiculo.
 */
class Debt extends Model
{
    use Timestamp;
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'id',
        'name',
        'description',
        'total_value',
        'debt_date',
        'max_pay_date'
    ];

    public function userToDebts()
    {
        return $this->hasMany(UserToDebt::class);
    }

    public function users()
    {
        return $this->hasManyThrough(User::class, UserToDebt::class);
    }

    public function proofs()
    {
        return $this->hasMany(DebtProof::class);
    }
}