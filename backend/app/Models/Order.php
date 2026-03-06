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
        'wallet_amount_used',
        'shipping_title',
        'shipping_amount',
        'coupon_code',
        'coupon_discount',
        'delivery_boy_id',
        'est_delivery_minutes',
        'est_delivery_set_at',
    ];

    protected function casts(): array
    {
        return [
            'total_amount' => 'decimal:2',
            'wallet_amount_used' => 'decimal:2',
            'shipping_amount' => 'decimal:2',
            'coupon_discount' => 'decimal:2',
            'status' => OrderStatus::class,
            'est_delivery_minutes' => 'integer',
            'est_delivery_set_at' => 'datetime',
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

    public function statusHistory()
    {
        return $this->hasMany(OrderStatusHistory::class, 'order_id')->orderBy('created_at');
    }
}
