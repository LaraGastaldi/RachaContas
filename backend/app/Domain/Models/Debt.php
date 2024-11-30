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
        'max_pay_date',
        'user_id'
    ];

    public function userToDebts()
    {
        return $this->hasMany(UserToDebt::class);
    }

    public function users()
    {
        return $this->hasMany(UserToDebt::class);
    }

    public function proofs()
    {
        return $this->hasMany(DebtProof::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    protected static function booted()
    {
        static::deleting(function (Debt $debt) {
            $debt->users()->delete();
            $debt->proofs()->delete();
        });
    }
}