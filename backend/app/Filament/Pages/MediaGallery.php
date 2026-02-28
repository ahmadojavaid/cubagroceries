<?php

namespace App\Filament\Pages;

use App\Models\MediaLibrary;
use Filament\Forms;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Illuminate\Support\Facades\Storage;
use Livewire\WithFileUploads;

class MediaGallery extends Page implements HasForms
{
    use InteractsWithForms;
    use WithFileUploads;

    protected static ?string $navigationIcon = 'heroicon-o-photo';
    protected static ?string $navigationLabel = 'Media Gallery';
    protected static ?string $navigationGroup = 'Content';
    protected static ?int $navigationSort = 10;
    protected static ?string $title = 'Media Gallery';
    protected static string $view = 'filament.pages.media-gallery';

    public ?string $filterFolder = null;
    public ?string $search = '';
    public $uploadFiles = [];
    public ?string $uploadFolder = 'general';

    public function getFilteredMedia()
    {
        return MediaLibrary::query()
            ->images()
            ->when($this->filterFolder, fn ($q) => $q->where('folder', $this->filterFolder))
            ->when($this->search, fn ($q) => $q->where(function ($q2) {
                $q2->where('original_name', 'ilike', "%{$this->search}%")
                   ->orWhere('alt', 'ilike', "%{$this->search}%");
            }))
            ->latest()
            ->paginate(24);
    }

    public function getFolders(): array
    {
        return MediaLibrary::query()
            ->select('folder')
            ->distinct()
            ->whereNotNull('folder')
            ->orderBy('folder')
            ->pluck('folder')
            ->toArray();
    }

    public function updatedUploadFiles(): void
    {
        $this->validate([
            'uploadFiles.*' => 'image|max:5120', // 5MB max
        ]);

        $count = 0;
        $disk = Storage::disk('public');
        $folder = $this->uploadFolder ?: 'general';

        foreach ($this->uploadFiles as $file) {
            $filename = time() . '_' . $count . '_' . str_replace(' ', '-', $file->getClientOriginalName());
            $path = $file->storeAs($folder, $filename, 'public');

            MediaLibrary::create([
                'filename' => $filename,
                'original_name' => $file->getClientOriginalName(),
                'disk' => 'public',
                'path' => $path,
                'mime_type' => $file->getMimeType(),
                'size' => $file->getSize(),
                'alt' => pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME),
                'folder' => $folder,
            ]);

            $count++;
        }

        $this->uploadFiles = [];

        Notification::make()
            ->title("Uploaded $count image" . ($count !== 1 ? 's' : ''))
            ->success()
            ->send();
    }

    public function deleteMedia(int $id): void
    {
        $media = MediaLibrary::findOrFail($id);

        // Delete file from disk
        Storage::disk($media->disk)->delete($media->path);

        $media->delete();

        Notification::make()
            ->title('Image deleted')
            ->success()
            ->send();
    }

    public function copyPath(int $id): void
    {
        $media = MediaLibrary::findOrFail($id);

        $this->dispatch('copy-to-clipboard', path: $media->path);

        Notification::make()
            ->title('Path copied!')
            ->body($media->path)
            ->success()
            ->send();
    }
}
