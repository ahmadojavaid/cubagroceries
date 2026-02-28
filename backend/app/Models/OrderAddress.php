<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderAddress extends Model
{
    protected $table = 'orderaddress';

    protected $fillable = [
        'order_id',
        'address',
        'city',
        'phone',
        'latitude',
        'longitude',
    ];

    protected function casts(): array
    {
        return [
            'latitude' => 'decimal:7',
            'longitude' => 'decimal:7',
        ];
    }

    // Relationships

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }
}
