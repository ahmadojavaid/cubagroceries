@php
    $record = $getRecord();
    $history = $record->statusHistory()->orderBy('created_at')->get();

    // All possible statuses in order for the progress bar
    $allSteps = [
        'pending'    => ['label' => 'Pending',    'icon' => 'clock',      'color' => 'amber'],
        'confirmed'  => ['label' => 'Confirmed',  'icon' => 'check',      'color' => 'blue'],
        'dispatched' => ['label' => 'Dispatched', 'icon' => 'truck',      'color' => 'indigo'],
        'delivered'  => ['label' => 'Delivered',  'icon' => 'check-badge','color' => 'emerald'],
    ];

    $isCancelled = $record->status->value === 'cancelled';
    $currentStatus = $record->status->value;

    // Build a lookup: status → history entry
    $historyMap = [];
    foreach ($history as $entry) {
        $historyMap[$entry->to_status] = $entry;
    }

    // Determine which steps are reached
    $statusOrder = array_keys($allSteps);
    $currentIndex = array_search($currentStatus, $statusOrder);
@endphp

{{-- Progress Steps (horizontal) --}}
@if(!$isCancelled)
<div class="flex items-start gap-0 mb-8">
    @foreach($allSteps as $status => $step)
        @php
            $index = array_search($status, $statusOrder);
            $reached = isset($historyMap[$status]);
            $isCurrent = $status === $currentStatus;
            $entry = $historyMap[$status] ?? null;

            $dotColor = $reached
                ? 'bg-' . $step['color'] . '-500'
                : 'bg-gray-200 dark:bg-gray-700';
            $textColor = $reached
                ? 'text-' . $step['color'] . '-600 dark:text-' . $step['color'] . '-400'
                : 'text-gray-400 dark:text-gray-500';
            $lineColor = $reached
                ? 'bg-' . $step['color'] . '-400'
                : 'bg-gray-200 dark:bg-gray-700';
        @endphp
        <div class="flex-1 flex flex-col items-center relative">
            {{-- Connector line (before dot, except first) --}}
            @if(!$loop->first)
                <div class="absolute top-3 right-1/2 left-0 h-0.5 -translate-x-0 {{ $reached ? 'bg-' . $step['color'] . '-300 dark:bg-' . $step['color'] . '-700' : 'bg-gray-200 dark:bg-gray-700' }}" style="z-index:0; left:-50%; right:50%;"></div>
            @endif

            {{-- Dot --}}
            <div class="relative z-10 w-6 h-6 rounded-full flex items-center justify-center {{ $reached ? 'bg-' . $step['color'] . '-100 dark:bg-' . $step['color'] . '-900/40 ring-2 ring-' . $step['color'] . '-400' : 'bg-gray-100 dark:bg-gray-800 ring-2 ring-gray-300 dark:ring-gray-600' }} {{ $isCurrent ? 'ring-offset-2 ring-offset-white dark:ring-offset-gray-900' : '' }}">
                @if($reached)
                    <svg class="w-3.5 h-3.5 text-{{ $step['color'] }}-500" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                    </svg>
                @else
                    <div class="w-2 h-2 rounded-full bg-gray-300 dark:bg-gray-600"></div>
                @endif
            </div>

            {{-- Label --}}
            <span class="mt-2 text-xs font-semibold {{ $textColor }}">{{ $step['label'] }}</span>

            {{-- Timestamp --}}
            @if($entry)
                <span class="mt-0.5 text-[10px] text-gray-400 dark:text-gray-500">
                    {{ $entry->created_at->format('M d, H:i') }}
                </span>
            @endif
        </div>
    @endforeach
</div>
@endif

{{-- Cancelled badge --}}
@if($isCancelled)
<div class="flex items-center gap-2 mb-6 px-3 py-2 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800">
    <svg class="w-5 h-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
    </svg>
    <span class="text-sm font-semibold text-red-600 dark:text-red-400">Order Cancelled</span>
    @if(isset($historyMap['cancelled']))
        <span class="text-xs text-red-400 dark:text-red-500 ml-auto">
            {{ $historyMap['cancelled']->created_at->format('M d, Y H:i') }}
            @if($historyMap['cancelled']->changed_by)
                &middot; by {{ $historyMap['cancelled']->changed_by }}
            @endif
        </span>
    @endif
</div>
@endif

{{-- Detailed timeline --}}
@if($history->isNotEmpty())
<div class="relative pl-6 border-l-2 border-gray-200 dark:border-gray-700 space-y-4">
    @foreach($history as $entry)
        @php
            $statusMeta = match($entry->to_status) {
                'pending'    => ['color' => 'amber',   'icon' => '🕐'],
                'confirmed'  => ['color' => 'blue',    'icon' => '✓'],
                'dispatched' => ['color' => 'indigo',  'icon' => '🚚'],
                'delivered'  => ['color' => 'emerald', 'icon' => '✅'],
                'cancelled'  => ['color' => 'red',     'icon' => '✕'],
                default      => ['color' => 'gray',    'icon' => '•'],
            };
        @endphp
        <div class="relative">
            {{-- Dot on the line --}}
            <div class="absolute -left-[25px] top-1 w-3 h-3 rounded-full bg-{{ $statusMeta['color'] }}-400 ring-2 ring-white dark:ring-gray-900"></div>

            <div class="flex items-baseline gap-3">
                {{-- Status label --}}
                <span class="inline-flex items-center gap-1 text-sm font-semibold text-{{ $statusMeta['color'] }}-600 dark:text-{{ $statusMeta['color'] }}-400">
                    <span>{{ $statusMeta['icon'] }}</span>
                    {{ ucfirst($entry->to_status) }}
                </span>

                {{-- From status --}}
                @if($entry->from_status)
                    <span class="text-xs text-gray-400 dark:text-gray-500">
                        from {{ ucfirst($entry->from_status) }}
                    </span>
                @endif
            </div>

            <div class="flex items-center gap-3 mt-0.5">
                {{-- Timestamp --}}
                <span class="text-xs text-gray-500 dark:text-gray-400">
                    {{ $entry->created_at->format('M d, Y \a\t h:i A') }}
                </span>

                {{-- Changed by --}}
                @if($entry->changed_by)
                    <span class="text-xs text-gray-400 dark:text-gray-500">
                        &middot; by <span class="font-medium text-gray-500 dark:text-gray-400">{{ $entry->changed_by }}</span>
                    </span>
                @endif
            </div>

            {{-- Note --}}
            @if($entry->note)
                <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500 italic">
                    {{ $entry->note }}
                </p>
            @endif
        </div>
    @endforeach
</div>
@else
    <p class="text-sm text-gray-400 dark:text-gray-500 italic">
        No fulfilment trail recorded yet.
        @if($record->created_at)
            Order was placed on {{ $record->created_at->format('M d, Y \a\t h:i A') }}.
        @endif
    </p>
@endif
