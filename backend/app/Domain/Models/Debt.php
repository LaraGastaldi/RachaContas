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
        'total_value',
        'debt_date',
        'max_pay_date'
    ];
}