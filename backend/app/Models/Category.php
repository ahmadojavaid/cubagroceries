<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table = 'category';

    protected $fillable = [
        'title',
        'image',
        'parent_id',
        'is_featured',
    ];

    protected function casts(): array
    {
        return [
            'is_featured' => 'boolean',
        ];
    }

    // Relationships

    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    public function products()
    {
        return $this->hasMany(Product::class);
    }

    /**
     * Products where this category is the sub_category.
     */
    public function subCategoryProducts()
    {
        return $this->hasMany(Product::class, 'sub_category_id');
    }

    /**
     * Count all products belonging to this category (as main or sub).
     */
    public function getAllProductsCountAttribute(): int
    {
        return Product::where('category_id', $this->id)
            ->orWhere('sub_category_id', $this->id)
            ->count();
    }

    // Scopes

    public function scopeTopLevel($query)
    {
        return $query->whereNull('parent_id');
    }

    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }
}
