<?php

namespace App\Services;

use App\Models\Order;

class OrderIdGenerator
{
    /**
     * Generate a unique order ID with CUBA prefix + 8 random digits.
     * Example: CUBA89162301
     */
    public static function generate(): string
    {
        do {
            $orderId = 'CUBA' . str_pad(random_int(0, 99999999), 8, '0', STR_PAD_LEFT);
        } while (Order::where('order_id', $orderId)->exists());

        return $orderId;
    }
}
