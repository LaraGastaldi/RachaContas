<?php

namespace App\Domain\Enum;

class UserToDebtRelationship
{
    static const RECEIVER = 'receiver';
    static const PAYER = 'payer';
    static const WITNESS = 'witness';

    public static function getRelationships()
    {
        return [
            self::RECEIVER,
            self::PAYER,
            self::WITNESS,
        ];
    }
}