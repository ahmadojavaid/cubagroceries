<x-filament-panels::page>
    {{-- Instant Online/Offline Toggle --}}
    <div class="mb-6">
        <div @class([
            'rounded-xl p-6 flex items-center justify-between',
            'bg-red-50 dark:bg-red-500/10 border border-red-200 dark:border-red-500/20' => $this->is_store_offline,
            'bg-green-50 dark:bg-green-500/10 border border-green-200 dark:border-green-500/20' => !$this->is_store_offline,
        ])>
            <div class="flex items-center gap-4">
                <div @class([
                    'w-14 h-14 rounded-full flex items-center justify-center',
                    'bg-red-100 dark:bg-red-500/20' => $this->is_store_offline,
                    'bg-green-100 dark:bg-green-500/20' => !$this->is_store_offline,
                ])>
                    @if($this->is_store_offline)
                        <x-heroicon-o-x-circle class="w-7 h-7 text-red-600 dark:text-red-400" />
                    @else
                        <x-heroicon-o-check-circle class="w-7 h-7 text-green-600 dark:text-green-400" />
                    @endif
                </div>
                <div>
                    <h3 @class([
                        'text-lg font-bold',
                        'text-red-800 dark:text-red-300' => $this->is_store_offline,
                        'text-green-800 dark:text-green-300' => !$this->is_store_offline,
                    ])>
                        Store is {{ $this->is_store_offline ? 'OFFLINE' : 'ONLINE' }}
                    </h3>
                    <p class="text-sm text-gray-500 dark:text-gray-400 mt-0.5">
                        @if($this->is_store_offline)
                            Customers see the holiday banner. {{ ($this->data['allow_advance_orders'] ?? true) ? '"Order for Later" is enabled.' : 'Ordering is disabled.' }}
                        @else
                            Store is accepting orders normally.
                        @endif
                    </p>
                </div>
            </div>

            <x-filament::button
                wire:click="toggleOnlineStatus"
                :color="$this->is_store_offline ? 'success' : 'danger'"
                size="lg"
                :icon="$this->is_store_offline ? 'heroicon-o-signal' : 'heroicon-o-no-symbol'"
            >
                {{ $this->is_store_offline ? 'Go Online' : 'Go Offline Now' }}
            </x-filament::button>
        </div>
    </div>

    {{-- Holiday Configuration Form --}}
    <form wire:submit="save">
        {{ $this->form }}

        <div class="mt-6">
            <x-filament::button type="submit" size="lg">
                Save Holiday Settings
            </x-filament::button>
        </div>
    </form>
</x-filament-panels::page>
