<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;

class PortalUser extends Authenticatable
{
    const ROLE_SUPER_ADMIN = 1;
    const ROLE_ADMIN = 2;
    const ROLE_STAFF = 3;

    protected $table = 'portal_users';

    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'password' => 'hashed',
            'role' => 'integer',
        ];
    }

    // Helpers

    public function isSuperAdmin(): bool
    {
        return $this->role === self::ROLE_SUPER_ADMIN;
    }

    public function isAdmin(): bool
    {
        return $this->role <= self::ROLE_ADMIN;
    }

    public function getRoleLabelAttribute(): string
    {
        return match ($this->role) {
            self::ROLE_SUPER_ADMIN => 'Super Admin',
            self::ROLE_ADMIN => 'Admin',
            self::ROLE_STAFF => 'Staff',
            default => 'Unknown',
        };
    }
}
