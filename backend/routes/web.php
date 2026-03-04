<?php

use App\Http\Controllers\InvoiceController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

// Invoice (portal-authenticated)
Route::get('/admin/orders/{order}/invoice', [InvoiceController::class, 'show'])
    ->name('orders.invoice');
