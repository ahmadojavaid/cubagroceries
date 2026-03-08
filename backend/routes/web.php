<?php

use App\Http\Controllers\InvoiceController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

// Public pages
Route::get('/privacy-policy', function () {
    return view('privacy-policy');
})->name('privacy-policy');

Route::get('/delete-account', function () {
    return view('delete-account');
})->name('delete-account');

// Invoice (portal-authenticated)
Route::get('/admin/orders/{order}/invoice', [InvoiceController::class, 'show'])
    ->name('orders.invoice');
