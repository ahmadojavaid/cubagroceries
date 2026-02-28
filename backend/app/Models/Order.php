<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $table = 'orderdetails';

    protected $fillable = [
        'order_id',
        'user_id',
        'status',
        'total_amount',
    ];

    protected function casts(): array
    {
        return [
            'total_amount' => 'decimal:2',
        ];
    }

    // Relationships

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function address()
    {
        return $this->hasOne(OrderAddress::class, 'order_id');
    }

    public function products()
    {
        return $this->hasMany(Orderproduct::class, 'order_id');
    }
}
