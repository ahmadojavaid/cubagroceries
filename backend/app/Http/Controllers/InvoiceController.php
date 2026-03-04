<?php

namespace App\Http\Controllers;

use App\Models\AppSetting;
use App\Models\Order;

class InvoiceController extends Controller
{
    public function show(Order $order)
    {
        // Only portal-authenticated users
        if (!auth('portal')->check()) {
            abort(403);
        }

        $order->load([
            'user',
            'address',
            'products.product:id,name,image',
            'products.unit:id,name',
            'deliveryBoy:id,name,phone',
        ]);

        $settings = AppSetting::pluck('value', 'key');

        return view('invoices.order', compact('order', 'settings'));
    }
}
