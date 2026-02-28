<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

return new class extends Migration
{
    public function up(): void
    {
        $disk = Storage::disk('public');

        $folders = ['products', 'categories', 'banners'];

        foreach ($folders as $folder) {
            $files = $disk->files($folder);

            foreach ($files as $filePath) {
                if (str_starts_with(basename($filePath), '.')) continue;

                $fullPath = $disk->path($filePath);
                $size = file_exists($fullPath) ? filesize($fullPath) : 0;
                $mime = file_exists($fullPath) ? (mime_content_type($fullPath) ?: 'image/jpeg') : 'image/jpeg';

                DB::table('media_library')->insert([
                    'filename' => basename($filePath),
                    'original_name' => basename($filePath),
                    'disk' => 'public',
                    'path' => $filePath,
                    'mime_type' => $mime,
                    'size' => $size,
                    'alt' => str_replace(['-', '_', '.jpg', '.png', '.webp'], [' ', ' ', '', '', ''], basename($filePath)),
                    'folder' => $folder,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }

    public function down(): void
    {
        DB::table('media_library')->truncate();
    }
};
