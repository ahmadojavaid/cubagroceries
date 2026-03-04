@php
    $record = $getRecord();
    $orders = $record->orders()
        ->with(['products', 'deliveryBoy:id,name'])
        ->withCount('products')
        ->orderByDesc('created_at')
        ->limit(25)
        ->get();
@endphp

@if($orders->isEmpty())
    <p class="text-sm text-gray-500 dark:text-gray-400 italic">No orders yet.</p>
@else
    <div class="overflow-x-auto">
        <table class="w-full text-sm text-left">
            <thead class="text-xs text-gray-500 dark:text-gray-400 uppercase border-b dark:border-gray-700">
                <tr>
                    <th class="px-3 py-2">Order #</th>
                    <th class="px-3 py-2">Status</th>
                    <th class="px-3 py-2">Items</th>
                    <th class="px-3 py-2">Total</th>
                    <th class="px-3 py-2">Rider</th>
                    <th class="px-3 py-2">Placed</th>
                    <th class="px-3 py-2"></th>
                </tr>
            </thead>
            <tbody class="divide-y dark:divide-gray-700">
                @foreach($orders as $order)
                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50">
                        <td class="px-3 py-2.5 font-medium text-gray-900 dark:text-white">
                            {{ $order->order_id }}
                        </td>
                        <td class="px-3 py-2.5">
                            @php
                                $colors = [
                                    'pending' => 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400',
                                    'confirmed' => 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400',
                                    'dispatched' => 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900/30 dark:text-indigo-400',
                                    'delivered' => 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400',
                                    'cancelled' => 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400',
                                ];
                                $statusClass = $colors[$order->status->value ?? $order->status] ?? 'bg-gray-100 text-gray-800';
                                $statusLabel = ucfirst($order->status->value ?? $order->status);
                            @endphp
                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium {{ $statusClass }}">
                                {{ $statusLabel }}
                            </span>
                        </td>
                        <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400">
                            {{ $order->products_count }}
                        </td>
                        <td class="px-3 py-2.5 font-medium text-gray-900 dark:text-white">
                            Rs {{ number_format($order->total_amount, 0) }}
                        </td>
                        <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400">
                            {{ $order->deliveryBoy?->name ?? '—' }}
                        </td>
                        <td class="px-3 py-2.5 text-gray-500 dark:text-gray-400">
                            {{ $order->created_at->format('M d, Y H:i') }}
                        </td>
                        <td class="px-3 py-2.5">
                            <a href="{{ \App\Filament\Resources\OrderResource::getUrl('view', ['record' => $order]) }}"
                               class="text-primary-600 hover:text-primary-800 dark:text-primary-400 dark:hover:text-primary-300 text-xs font-medium">
                                View →
                            </a>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    @if($record->orders()->count() > 25)
        <p class="text-xs text-gray-400 dark:text-gray-500 mt-2 text-right">
            Showing latest 25 of {{ $record->orders()->count() }} orders
        </p>
    @endif
@endif
