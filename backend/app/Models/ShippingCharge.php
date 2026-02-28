<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShippingCharge extends Model
{
    protected $table = 'shippingcharge';

    protected $fillable = [
        'title',
        'amount',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
        ];
    }
}
