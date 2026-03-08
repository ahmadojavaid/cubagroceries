<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\AppSetting;

class AppSettingController extends Controller
{
    public function index()
    {
        $keys = [
            'app_name',
            'contact_email',
            'contact_phone',
            'whatsapp_number',
            'min_order_amount',
            'currency_symbol',
            'delivery_time_text',
            'about_us',
            'terms_and_conditions',
            'privacy_policy',
        ];

        $settings = AppSetting::whereIn('key', $keys)
            ->pluck('value', 'key')
            ->toArray();

        return response()->json([
            'success' => true,
            'data' => $settings,
        ]);
    }

    /**
     * GET /api/v1/store-status
     * Lightweight endpoint returning just the holiday/offline status.
     */
    public function storeStatus()
    {
        return response()->json([
            'success' => true,
            'data' => \App\Filament\Pages\StoreHolidayMode::getHolidayData(),
        ]);
    }
}
