<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $table = 'product';

    protected $fillable = [
        'name',
        'description',
        'image',
        'category_id',
        'sub_category_id',
        'stock',
    ];

    protected function casts(): array
    {
        return [
            'stock' => 'integer',
        ];
    }

    // Relationships

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function subCategory()
    {
        return $this->belongsTo(Category::class, 'sub_category_id');
    }

    public function prices()
    {
        return $this->hasMany(Price::class);
    }

    public function reviews()
    {
        return $this->hasMany(Review::class);
    }

    // Scopes

    public function scopeInStock($query)
    {
        return $query->where('stock', '>', 0);
    }
}
