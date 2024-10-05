<?php

namespace App\Domain\Enum;

class UserToDebtRelationship
{
    const RECEIVER = 'receiver';
    const PAYER = 'payer';
    const WITNESS = 'witness';

    public static function getRelationships()
    {
        return [
            self::RECEIVER,
            self::PAYER,
            self::WITNESS,
        ];
    }
}