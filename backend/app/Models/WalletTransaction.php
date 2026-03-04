<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WalletTransaction extends Model
{
    protected $fillable = [
        'user_id',
        'type',
        'amount',
        'balance_after',
        'source',
        'reference_id',
        'note',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'balance_after' => 'decimal:2',
        ];
    }

    // ── Relationships ───────────────────────────────────────

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // ── Helpers ─────────────────────────────────────────────

    /**
     * Record a credit (money in).
     */
    public static function recordCredit(
        int $userId,
        float $amount,
        string $source,
        ?int $referenceId = null,
        ?string $note = null,
    ): self {
        $user = User::findOrFail($userId);

        return self::create([
            'user_id' => $userId,
            'type' => 'credit',
            'amount' => $amount,
            'balance_after' => $user->wallet_amount,
            'source' => $source,
            'reference_id' => $referenceId,
            'note' => $note,
        ]);
    }

    /**
     * Record a debit (money out).
     */
    public static function recordDebit(
        int $userId,
        float $amount,
        string $source,
        ?int $referenceId = null,
        ?string $note = null,
    ): self {
        $user = User::findOrFail($userId);

        return self::create([
            'user_id' => $userId,
            'type' => 'debit',
            'amount' => $amount,
            'balance_after' => $user->wallet_amount,
            'source' => $source,
            'reference_id' => $referenceId,
            'note' => $note,
        ]);
    }
}
