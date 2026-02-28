<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CategoriesController;
use App\Http\Controllers\Api\V1\ProductsController;
use App\Http\Controllers\Api\V1\ProfileController;
use App\Http\Controllers\Api\V1\AddressController;
use App\Http\Controllers\Api\V1\WalletController;
use App\Http\Controllers\Api\V1\HomeController;
use App\Http\Controllers\Api\V1\ShippingController;
use App\Http\Controllers\Api\V1\OrderController;
use App\Http\Controllers\Api\V1\ComplaintController;
use App\Http\Controllers\Api\V1\NotificationController;
use App\Http\Controllers\Api\V1\DeviceTokenController;
use App\Http\Controllers\Api\V1\FaqController;
use App\Http\Controllers\Api\V1\StoreScheduleController;
use App\Http\Controllers\Api\V1\AppSettingController;
use App\Http\Controllers\Api\V1\CouponController;
use App\Http\Controllers\Api\V1\ReviewController;
use App\Http\Controllers\Api\V1\SurveyController;
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

        // Home & Banners
        Route::get('/home', [HomeController::class, 'home']);
        Route::get('/banners', [HomeController::class, 'banners']);

        // Categories
        Route::get('/categories', [CategoriesController::class, 'index']);
        Route::get('/categories/{id}', [CategoriesController::class, 'show']);
        Route::get('/categories/{id}/products', [CategoriesController::class, 'products']);

        // Products
        Route::get('/products', [ProductsController::class, 'index']);
        Route::get('/products/search', [ProductsController::class, 'search']);
        Route::get('/products/{id}', [ProductsController::class, 'show']);

        // Profile
        Route::get('/profile', [ProfileController::class, 'show']);
        Route::put('/profile', [ProfileController::class, 'update']);
        Route::put('/profile/password', [ProfileController::class, 'password']);

        // Addresses
        Route::get('/addresses', [AddressController::class, 'index']);
        Route::post('/addresses', [AddressController::class, 'store']);
        Route::put('/addresses/{id}', [AddressController::class, 'update']);
        Route::delete('/addresses/{id}', [AddressController::class, 'destroy']);
        Route::put('/addresses/{id}/default', [AddressController::class, 'setDefault']);

        // Wallet
        Route::get('/wallet', [WalletController::class, 'balance']);

        // Shipping
        Route::get('/shipping-charges', [ShippingController::class, 'index']);

        // Orders
        Route::get('/orders', [OrderController::class, 'index']);
        Route::post('/orders', [OrderController::class, 'store']);
        Route::get('/orders/{orderNumber}', [OrderController::class, 'show']);

        // Complaints
        Route::get('/complaints', [ComplaintController::class, 'index']);
        Route::post('/complaints', [ComplaintController::class, 'store']);

        // Notifications
        Route::get('/notifications', [NotificationController::class, 'index']);
        Route::put('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
        Route::put('/notifications/read-all', [NotificationController::class, 'markAllAsRead']);

        // Device Token (FCM)
        Route::post('/device-token', [DeviceTokenController::class, 'store']);

        // FAQs
        Route::get('/faqs', [FaqController::class, 'index']);

        // Store Schedules
        Route::get('/store-schedules', [StoreScheduleController::class, 'index']);

        // App Settings (public config)
        Route::get('/settings', [AppSettingController::class, 'index']);

        // Coupons
        Route::post('/coupons/apply', [CouponController::class, 'apply']);

        // Reviews — Product
        Route::get('/products/{productId}/reviews', [ReviewController::class, 'forProduct']);
        Route::post('/reviews', [ReviewController::class, 'store']);
        Route::get('/orders/{orderId}/reviewable-products', [ReviewController::class, 'reviewableProducts']);

        // Reviews — Order
        Route::post('/order-reviews', [ReviewController::class, 'storeOrderReview']);
        Route::get('/orders/{orderId}/review', [ReviewController::class, 'orderReview']);

        // Surveys
        Route::get('/surveys', [SurveyController::class, 'index']);
        Route::post('/surveys/{surveyId}/respond', [SurveyController::class, 'respond']);
    });
});
