<x-filament-panels::page>
    <form wire:submit="send">
        {{ $this->form }}

        <div class="mt-6">
            <x-filament::button type="submit" size="lg">
                <x-slot name="icon">
                    <x-heroicon-o-paper-airplane class="w-5 h-5" />
                </x-slot>
                Send Notification
            </x-filament::button>
        </div>
    </form>
</x-filament-panels::page>
