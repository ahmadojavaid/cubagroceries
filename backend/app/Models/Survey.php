<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Survey extends Model
{
    protected $fillable = [
        'question',
        'options',
        'is_active',
        'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'options' => 'array',
            'is_active' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    public function responses()
    {
        return $this->hasMany(SurveyResponse::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }
}
