<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CategoriesController;
use App\Http\Controllers\Api\V1\ProductsController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {

    // Auth — Public (rate limited: 5/min)
    Route::prefix('auth')->middleware('throttle:5,1')->group(function () {
        Route::post('/register', [AuthController::class, 'register']);
        Route::post('/login', [AuthController::class, 'login']);
    });

    // Auth — Protected
    Route::prefix('auth')->middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/user', [AuthController::class, 'user']);
    });

    // Protected API routes
    Route::middleware('auth:sanctum')->group(function () {

        // Categories
        Route::get('/categories', [CategoriesController::class, 'index']);
        Route::get('/categories/{id}', [CategoriesController::class, 'show']);
        Route::get('/categories/{id}/products', [CategoriesController::class, 'products']);

        // Products
        Route::get('/products', [ProductsController::class, 'index']);
        Route::get('/products/search', [ProductsController::class, 'search']);
        Route::get('/products/{id}', [ProductsController::class, 'show']);
    });
});
