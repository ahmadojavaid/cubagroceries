<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WalletController extends Controller
{
    use ApiResponse;

    /**
     * GET /api/v1/wallet
     */
    public function balance(Request $request): JsonResponse
    {
        return $this->success([
            'wallet_amount' => $request->user()->wallet_amount,
        ]);
    }
}
