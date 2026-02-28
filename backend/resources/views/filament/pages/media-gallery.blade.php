<x-filament-panels::page>
    <div x-data="{ showUpload: false }" class="space-y-6">

        {{-- Toolbar --}}
        <div class="flex flex-wrap items-center gap-3">
            {{-- Search --}}
            <div class="flex-1 min-w-[200px]">
                <input
                    type="text"
                    wire:model.live.debounce.300ms="search"
                    placeholder="Search images..."
                    class="w-full rounded-lg border-gray-300 dark:border-gray-700 dark:bg-gray-900 text-sm shadow-sm focus:border-primary-500 focus:ring-primary-500"
                />
            </div>

            {{-- Folder filter --}}
            <select
                wire:model.live="filterFolder"
                class="rounded-lg border-gray-300 dark:border-gray-700 dark:bg-gray-900 text-sm shadow-sm"
            >
                <option value="">All Folders</option>
                @foreach ($this->getFolders() as $folder)
                    <option value="{{ $folder }}">{{ ucfirst($folder) }}</option>
                @endforeach
            </select>

            {{-- Upload toggle --}}
            <button
                @click="showUpload = !showUpload"
                class="inline-flex items-center gap-2 rounded-lg bg-primary-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-primary-500 transition"
            >
                <x-heroicon-m-arrow-up-tray class="w-4 h-4" />
                Upload Images
            </button>
        </div>

        {{-- Upload panel --}}
        <div x-show="showUpload" x-transition class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 p-5 space-y-4">
            <div class="flex items-center gap-4">
                <div class="flex-1">
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Upload to folder</label>
                    <select
                        wire:model="uploadFolder"
                        class="w-full rounded-lg border-gray-300 dark:border-gray-700 dark:bg-gray-800 text-sm"
                    >
                        <option value="general">General</option>
                        <option value="products">Products</option>
                        <option value="categories">Categories</option>
                        <option value="banners">Banners</option>
                    </select>
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Select images</label>
                <input
                    type="file"
                    wire:model="uploadFiles"
                    multiple
                    accept="image/*"
                    class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100 dark:file:bg-primary-900/20 dark:file:text-primary-400"
                />
            </div>

            <div wire:loading wire:target="uploadFiles" class="flex items-center gap-2 text-sm text-primary-600">
                <x-heroicon-m-arrow-path class="w-4 h-4 animate-spin" />
                Uploading...
            </div>
        </div>

        {{-- Gallery grid --}}
        @php $media = $this->getFilteredMedia(); @endphp

        @if ($media->isEmpty())
            <div class="flex flex-col items-center justify-center py-16 text-gray-400">
                <x-heroicon-o-photo class="w-12 h-12 mb-3" />
                <p class="text-sm">No images found</p>
            </div>
        @else
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
                @foreach ($media as $item)
                    <div
                        class="group relative rounded-xl overflow-hidden border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm hover:shadow-md transition"
                    >
                        {{-- Image --}}
                        <div class="aspect-square bg-gray-100 dark:bg-gray-800">
                            <img
                                src="{{ $item->url }}"
                                alt="{{ $item->alt }}"
                                class="w-full h-full object-cover"
                                loading="lazy"
                            />
                        </div>

                        {{-- Overlay on hover --}}
                        <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-end">
                            <div class="w-full p-2 space-y-1">
                                <p class="text-white text-xs font-medium truncate">{{ $item->original_name }}</p>
                                <p class="text-gray-300 text-[10px]">{{ $item->human_size }} · {{ ucfirst($item->folder ?? 'general') }}</p>
                                <div class="flex gap-1 pt-1">
                                    <button
                                        wire:click="copyPath({{ $item->id }})"
                                        class="flex-1 rounded bg-white/20 px-2 py-1 text-[10px] text-white font-medium hover:bg-white/30 transition"
                                        title="Copy storage path"
                                    >
                                        Copy Path
                                    </button>
                                    <button
                                        wire:click="deleteMedia({{ $item->id }})"
                                        wire:confirm="Delete this image permanently?"
                                        class="rounded bg-red-500/80 px-2 py-1 text-[10px] text-white font-medium hover:bg-red-600 transition"
                                        title="Delete"
                                    >
                                        <x-heroicon-m-trash class="w-3 h-3" />
                                    </button>
                                </div>
                            </div>
                        </div>

                        {{-- Folder badge --}}
                        @if ($item->folder)
                            <div class="absolute top-2 left-2">
                                <span class="inline-block rounded-full bg-black/50 px-2 py-0.5 text-[9px] font-medium text-white">
                                    {{ ucfirst($item->folder) }}
                                </span>
                            </div>
                        @endif
                    </div>
                @endforeach
            </div>

            {{-- Pagination --}}
            <div class="mt-4">
                {{ $media->links() }}
            </div>
        @endif
    </div>

    {{-- Clipboard JS --}}
    @push('scripts')
    <script>
        document.addEventListener('livewire:initialized', () => {
            Livewire.on('copy-to-clipboard', ({ path }) => {
                navigator.clipboard.writeText(path).catch(() => {
                    // Fallback
                    const el = document.createElement('textarea');
                    el.value = path;
                    document.body.appendChild(el);
                    el.select();
                    document.execCommand('copy');
                    document.body.removeChild(el);
                });
            });
        });
    </script>
    @endpush
</x-filament-panels::page>
