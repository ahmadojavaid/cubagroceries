<div x-data="{ selected: null, selectedPath: null }">

    <style>
        .gallery-item {
            position: relative;
            aspect-ratio: 1/1;
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            border: 3px solid rgba(255,255,255,0.06);
            transition: border-color 0.15s, box-shadow 0.15s;
        }
        .gallery-item:hover {
            border-color: rgba(255,255,255,0.2);
        }
        .gallery-item.is-selected {
            border-color: rgb(234,88,12) !important;
            box-shadow: 0 0 0 3px rgba(234,88,12,0.25) !important;
        }
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .gallery-item .check-overlay {
            position: absolute;
            inset: 0;
            background: rgba(234,88,12,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }
        .gallery-save-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 20px;
            background: rgb(234,88,12);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s;
        }
        .gallery-save-btn:hover {
            background: rgb(196,90,26);
        }
        .gallery-save-btn:disabled {
            background: #4b5563;
            cursor: not-allowed;
            opacity: 0.5;
        }
    </style>

    @if ($images->isNotEmpty())
        <p style="font-size:11px;font-weight:600;color:#9ca3af;margin-bottom:12px;text-transform:uppercase;letter-spacing:0.05em;">{{ ucfirst($folder) }} Images</p>
        <div class="gallery-grid">
            @foreach ($images as $img)
                <div
                    class="gallery-item"
                    x-on:click="selected = {{ $img->id }}; selectedPath = '{{ $img->path }}';"
                    x-bind:class="selected === {{ $img->id }} && 'is-selected'"
                >
                    <img src="{{ $img->url }}" alt="{{ $img->alt }}" loading="lazy" />
                    <template x-if="selected === {{ $img->id }}">
                        <div class="check-overlay">
                            <div style="background:rgb(234,88,12);border-radius:50%;padding:5px;line-height:0;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                            </div>
                        </div>
                    </template>
                </div>
            @endforeach
        </div>
    @endif

    @if ($allImages->isNotEmpty())
        <p style="font-size:11px;font-weight:600;color:#9ca3af;margin-bottom:12px;text-transform:uppercase;letter-spacing:0.05em;">Other Images</p>
        <div class="gallery-grid">
            @foreach ($allImages as $img)
                <div
                    class="gallery-item"
                    x-on:click="selected = {{ $img->id }}; selectedPath = '{{ $img->path }}';"
                    x-bind:class="selected === {{ $img->id }} && 'is-selected'"
                >
                    <img src="{{ $img->url }}" alt="{{ $img->alt }}" loading="lazy" />
                    <template x-if="selected === {{ $img->id }}">
                        <div class="check-overlay">
                            <div style="background:rgb(234,88,12);border-radius:50%;padding:5px;line-height:0;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                            </div>
                        </div>
                    </template>
                </div>
            @endforeach
        </div>
    @endif

    @if ($images->isEmpty() && $allImages->isEmpty())
        <div style="text-align:center;padding:48px 0;color:#6b7280;">
            <p style="font-size:14px;">No images in gallery. Upload from the Media Gallery page first.</p>
        </div>
    @endif

    {{-- Footer with Save button --}}
    <div style="display:flex;align-items:center;justify-content:space-between;margin-top:16px;padding-top:16px;border-top:1px solid rgba(255,255,255,0.08);">
        <p style="font-size:12px;color:#6b7280;margin:0;" x-text="selected ? 'Image selected — click Save to apply' : 'Click an image to select it'"></p>
        <button
            class="gallery-save-btn"
            x-bind:disabled="!selected"
            x-on:click="if(selectedPath) { $wire.set('data.image', selectedPath); $dispatch('close-modal', { id: 'pick_from_gallery' }); }"
        >
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
            Save
        </button>
    </div>
</div>
