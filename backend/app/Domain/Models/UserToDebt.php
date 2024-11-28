<?php

namespace App\Domain\Models;
use Illuminate\Database\Eloquent\Model;

class UserToDebt extends Model
{
    protected $table = 'user_to_debt';
    protected $fillable = [
        'relationship',
        'phone',
        'email',
        'email_sent_at',
        'sms_sent_at',
        'verified_at',
        'value',
        'user_id',
        'debt_id',
        'verify_code',
        'name',
        'paid_value'
    ];

    public function user(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function debt(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Debt::class);
    }
}