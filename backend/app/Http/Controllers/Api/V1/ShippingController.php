<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\ShippingCharge;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;

class ShippingController extends Controller
{
    use ApiResponse;

    public function index(): JsonResponse
    {
        $charges = ShippingCharge::orderBy('id')->get();

        return $this->success($charges);
    }
}
