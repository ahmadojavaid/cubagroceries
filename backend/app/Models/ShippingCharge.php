<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShippingCharge extends Model
{
    protected $table = 'shippingcharge';

    protected $fillable = [
        'title',
        'amount',
        'min_order_amount',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'min_order_amount' => 'decimal:2',
        ];
    }
}
