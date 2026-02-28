<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Orderproduct extends Model
{
    protected $table = 'orderproduct';

    protected $fillable = [
        'order_id',
        'product_id',
        'unit_id',
        'quantity',
        'price',
    ];

    protected function casts(): array
    {
        return [
            'quantity' => 'integer',
            'price' => 'decimal:2',
        ];
    }

    // Relationships

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }
}
