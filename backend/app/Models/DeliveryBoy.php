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
    ];

    protected function casts(): array
    {
        return [
            'payment' => 'decimal:2',
        ];
    }

    // Relationships

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
