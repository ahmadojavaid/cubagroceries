<?php

namespace App\Models;

use App\Enums\OrderStatus;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $table = 'orderdetails';

    protected $fillable = [
        'order_id',
        'user_id',
        'status',
        'total_amount',
        'delivery_boy_id',
    ];

    protected function casts(): array
    {
        return [
            'total_amount' => 'decimal:2',
            'status' => OrderStatus::class,
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

    public function deliveryBoy()
    {
        return $this->belongsTo(DeliveryBoy::class);
    }

    public function orderReview()
    {
        return $this->hasOne(OrderReview::class, 'order_id');
    }

    public function productReviews()
    {
        return $this->hasMany(Review::class, 'order_id');
    }
}
