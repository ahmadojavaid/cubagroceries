<x-filament-panels::page>
    <div class="flex gap-3 mb-4">
        <x-filament::button
            :color="$activeTab === 'today' ? 'primary' : 'gray'"
            wire:click="setTab('today')"
            size="sm"
        >
            🎂 Today
        </x-filament::button>

        <x-filament::button
            :color="$activeTab === 'this_week' ? 'primary' : 'gray'"
            wire:click="setTab('this_week')"
            size="sm"
        >
            📅 This Week
        </x-filament::button>

        <x-filament::button
            :color="$activeTab === 'this_month' ? 'primary' : 'gray'"
            wire:click="setTab('this_month')"
            size="sm"
        >
            🗓️ This Month
        </x-filament::button>
    </div>

    {{ $this->table }}
</x-filament-panels::page>
