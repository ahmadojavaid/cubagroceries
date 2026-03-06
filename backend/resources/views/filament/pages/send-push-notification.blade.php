<x-filament-panels::page>
    <form wire:submit="send">
        {{ $this->form }}

        <div class="mt-6 flex items-center gap-3">
            <x-filament::button type="submit" size="lg" wire:loading.attr="disabled">
                <span wire:loading.remove wire:target="send">
                    Send Notification
                </span>
                <span wire:loading wire:target="send">
                    Sending...
                </span>
            </x-filament::button>

            <span wire:loading wire:target="send" class="text-sm text-gray-500">
                Please wait while notifications are being sent...
            </span>
        </div>
    </form>
</x-filament-panels::page>
