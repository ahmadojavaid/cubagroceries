<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $fillable = [
        'identity',
        'email',
        'firstname',
        'lastname',
        'password',
        'date_of_birth',
        'wallet_amount',
        'role',
        'fcm_token',
    ];

    protected $hidden = [
        'password',
        'fcm_token',
    ];

    protected function casts(): array
    {
        return [
            'password' => 'hashed',
            'date_of_birth' => 'date:Y-m-d',
            'wallet_amount' => 'decimal:2',
        ];
    }

    // Role helpers

    public function isRider(): bool
    {
        return $this->role === 'rider';
    }

    public function isCustomer(): bool
    {
        return $this->role === 'customer';
    }

    // Relationships

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function addresses()
    {
        return $this->hasMany(Address::class);
    }

    public function complaints()
    {
        return $this->hasMany(Complaint::class);
    }

    public function deliveryBoy()
    {
        return $this->hasOne(DeliveryBoy::class);
    }

    public function walletTransactions()
    {
        return $this->hasMany(WalletTransaction::class);
    }

    // Accessors

    public function getFullNameAttribute(): string
    {
        return "{$this->firstname} {$this->lastname}";
    }
}
