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
            'date_of_birth' => 'date',
            'wallet_amount' => 'decimal:2',
        ];
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

    // Accessors

    public function getFullNameAttribute(): string
    {
        return "{$this->firstname} {$this->lastname}";
    }
}
