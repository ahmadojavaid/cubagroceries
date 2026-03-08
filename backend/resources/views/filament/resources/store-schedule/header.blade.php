<div class="space-y-4">
    {{-- Page heading with actions --}}
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-2xl font-bold tracking-tight text-gray-950 dark:text-white">Store Schedules</h1>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">Set daily operating hours for the store.</p>
        </div>
        <div>
            {{ $this->getHeaderActions()[0] ?? '' }}
        </div>
    </div>

    {{-- Enforce schedule toggle card --}}
    <div @class([
        'rounded-xl p-5 flex items-center justify-between',
        'bg-green-50 dark:bg-green-500/10 border border-green-200 dark:border-green-500/20' => $enforceSchedule,
        'bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700' => !$enforceSchedule,
    ])>
        <div class="flex items-center gap-4">
            <div @class([
                'w-11 h-11 rounded-full flex items-center justify-center',
                'bg-green-100 dark:bg-green-500/20' => $enforceSchedule,
                'bg-gray-200 dark:bg-gray-700' => !$enforceSchedule,
            ])>
                @if($enforceSchedule)
                    <x-heroicon-o-check-circle class="w-6 h-6 text-green-600 dark:text-green-400" />
                @else
                    <x-heroicon-o-clock class="w-6 h-6 text-gray-400 dark:text-gray-500" />
                @endif
            </div>
            <div>
                <h3 @class([
                    'text-sm font-semibold',
                    'text-green-800 dark:text-green-300' => $enforceSchedule,
                    'text-gray-700 dark:text-gray-300' => !$enforceSchedule,
                ])>
                    Auto Offline/Online {{ $enforceSchedule ? '— Active' : '— Disabled' }}
                </h3>
                <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                    @if($enforceSchedule)
                        Store automatically goes offline outside the hours below.
                        @if($todaySchedule)
                            @if($todaySchedule['is_closed'])
                                Today: <span class="font-medium text-red-600 dark:text-red-400">Closed</span>
                            @else
                                Today: {{ \Carbon\Carbon::parse($todaySchedule['open_time'])->format('g:i A') }} — {{ \Carbon\Carbon::parse($todaySchedule['close_time'])->format('g:i A') }}
                                @if($isOutsideHours)
                                    <span class="text-red-600 dark:text-red-400 font-medium">(currently outside hours)</span>
                                @else
                                    <span class="text-green-600 dark:text-green-400 font-medium">(currently open)</span>
                                @endif
                            @endif
                        @else
                            No schedule set for today.
                        @endif
                    @else
                        Enable to automatically take the store offline outside these hours.
                    @endif
                </p>
            </div>
        </div>

        <x-filament::button
            wire:click="toggleEnforce"
            :color="$enforceSchedule ? 'warning' : 'success'"
            size="sm"
        >
            {{ $enforceSchedule ? 'Disable' : 'Enable' }}
        </x-filament::button>
    </div>
</div>
