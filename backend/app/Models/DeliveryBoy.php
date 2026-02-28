<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DeliveryBoy extends Model
{
    protected $table = 'deliveryboy';

    protected $fillable = [
        'name',
        'phone',
        'payment',
        'user_id',
    ];

    protected function casts(): array
    {
        return [
            'payment' => 'decimal:2',
        ];
    }

    // Relationships

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
