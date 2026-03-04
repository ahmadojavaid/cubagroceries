<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\WalletTransaction;
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

    /**
     * GET /api/v1/wallet/transactions
     */
    public function transactions(Request $request): JsonResponse
    {
        $transactions = WalletTransaction::where('user_id', $request->user()->id)
            ->orderByDesc('created_at')
            ->paginate($request->input('per_page', 30));

        $data = $transactions->through(fn ($txn) => [
            'id' => $txn->id,
            'type' => $txn->type,
            'amount' => $txn->amount,
            'balance_after' => $txn->balance_after,
            'source' => $txn->source,
            'note' => $txn->note,
            'created_at' => $txn->created_at->toIso8601String(),
        ]);

        return response()->json([
            'success' => true,
            'data' => $data->items(),
            'meta' => [
                'current_page' => $data->currentPage(),
                'last_page' => $data->lastPage(),
                'per_page' => $data->perPage(),
                'total' => $data->total(),
            ],
        ]);
    }
}
