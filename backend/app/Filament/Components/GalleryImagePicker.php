<?php

namespace App\Filament\Components;

use App\Models\MediaLibrary;
use Filament\Forms;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\HtmlString;

class GalleryImagePicker
{
    public static function make(
        string $field = 'image',
        string $folder = 'general',
        string $directory = 'general',
    ): Forms\Components\Group {

        $fieldName = $field;
        $folderName = $folder;
        $dirName = $directory;

        return Forms\Components\Group::make([

            // Current image preview (always visible, shows placeholder if no image)
            Forms\Components\Placeholder::make($fieldName . '_preview')
                ->label('Image')
                ->content(function (Forms\Get $get) use ($fieldName) {
                    $path = $get($fieldName);
                    if (!$path) {
                        return new HtmlString(
                            '<div style="display:flex;align-items:center;gap:8px;color:#6b7280;font-size:13px;">'
                            . '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect width="18" height="18" x="3" y="3" rx="2" ry="2"/><circle cx="9" cy="9" r="2"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/></svg>'
                            . 'No image selected'
                            . '</div>'
                        );
                    }
                    $url = Storage::disk('public')->url($path);
                    return new HtmlString(
                        '<img src="' . e($url) . '" alt="Preview" '
                        . 'style="max-height:180px;border-radius:12px;object-fit:cover;border:1px solid rgba(255,255,255,0.1);" />'
                    );
                })
                ->live(),

            // Hidden field that stores the actual path
            Forms\Components\Hidden::make($fieldName)
                ->live(),

            // Action buttons row
            Forms\Components\Actions::make([

                // Pick from gallery
                Forms\Components\Actions\Action::make('pick_from_gallery')
                    ->label('Choose from Gallery')
                    ->icon('heroicon-o-photo')
                    ->color('gray')
                    ->modalHeading('Media Gallery — ' . ucfirst($folderName))
                    ->modalWidth('7xl')
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Close')
                    ->modalContent(function () use ($folderName) {
                        $images = MediaLibrary::query()
                            ->images()
                            ->where('folder', $folderName)
                            ->latest()
                            ->limit(60)
                            ->get();

                        $allImages = MediaLibrary::query()
                            ->images()
                            ->where('folder', '!=', $folderName)
                            ->latest()
                            ->limit(40)
                            ->get();

                        return view('filament.components.gallery-picker-modal', [
                            'images' => $images,
                            'allImages' => $allImages,
                            'folder' => $folderName,
                            'fieldName' => $folderName,
                        ]);
                    }),

                // Upload new
                Forms\Components\Actions\Action::make('upload_new_image')
                    ->label('Upload New')
                    ->icon('heroicon-o-arrow-up-tray')
                    ->color('primary')
                    ->form([
                        Forms\Components\FileUpload::make('new_upload')
                            ->label('Select Image')
                            ->image()
                            ->disk('public')
                            ->directory($dirName)
                            ->imageResizeMode('cover')
                            ->imageCropAspectRatio('1:1')
                            ->imageResizeTargetWidth('600')
                            ->imageResizeTargetHeight('600')
                            ->required(),
                    ])
                    ->action(function (array $data, Forms\Set $set) use ($fieldName, $folderName) {
                        $path = $data['new_upload'];
                        $set($fieldName, $path);

                        $existing = MediaLibrary::where('path', $path)->first();
                        if (!$existing) {
                            $disk = Storage::disk('public');
                            $fullPath = $disk->path($path);

                            MediaLibrary::create([
                                'filename' => basename($path),
                                'original_name' => basename($path),
                                'disk' => 'public',
                                'path' => $path,
                                'mime_type' => file_exists($fullPath) ? mime_content_type($fullPath) : 'image/jpeg',
                                'size' => file_exists($fullPath) ? filesize($fullPath) : 0,
                                'alt' => pathinfo(basename($path), PATHINFO_FILENAME),
                                'folder' => $folderName,
                            ]);
                        }
                    }),

                // Remove image
                Forms\Components\Actions\Action::make('remove_image')
                    ->label('Remove')
                    ->icon('heroicon-o-x-mark')
                    ->color('danger')
                    ->size('sm')
                    ->requiresConfirmation()
                    ->action(function (Forms\Set $set) use ($fieldName) {
                        $set($fieldName, null);
                    }),
            ]),

        ])->columnSpanFull();
    }
}
