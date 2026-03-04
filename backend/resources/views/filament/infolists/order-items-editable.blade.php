@php
    $record = $getRecord();
    $items = $record->products()->with(['product:id,name', 'unit:id,name'])->get();
@endphp

@if($items->isEmpty())
    <p class="text-sm text-gray-500 dark:text-gray-400 italic">No items in this order.</p>
@else
    <div class="overflow-x-auto">
        <table class="w-full text-sm text-left">
            <thead class="text-xs text-gray-500 dark:text-gray-400 uppercase border-b dark:border-gray-700">
                <tr>
                    <th class="px-3 py-2">#</th>
                    <th class="px-3 py-2">Product</th>
                    <th class="px-3 py-2">Unit</th>
                    <th class="px-3 py-2 text-center">Qty</th>
                    <th class="px-3 py-2 text-right">Price</th>
                    <th class="px-3 py-2 text-right">Total</th>
                </tr>
            </thead>
            <tbody class="divide-y dark:divide-gray-700">
                @foreach($items as $index => $item)
                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50">
                        <td class="px-3 py-2.5 text-gray-400 dark:text-gray-500">{{ $index + 1 }}</td>
                        <td class="px-3 py-2.5 font-medium text-gray-900 dark:text-white">
                            {{ $item->product?->name ?? 'Unknown' }}
                        </td>
                        <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400">
                            {{ $item->unit?->name ?? '—' }}
                        </td>
                        <td class="px-3 py-2.5 text-center font-medium text-gray-900 dark:text-white">
                            {{ $item->quantity }}
                        </td>
                        <td class="px-3 py-2.5 text-right text-gray-600 dark:text-gray-400">
                            Rs {{ number_format($item->price, 0) }}
                        </td>
                        <td class="px-3 py-2.5 text-right font-medium text-gray-900 dark:text-white">
                            Rs {{ number_format($item->price * $item->quantity, 0) }}
                        </td>
                    </tr>
                @endforeach
            </tbody>
            <tfoot class="border-t-2 dark:border-gray-600">
                <tr>
                    <td colspan="5" class="px-3 py-2.5 text-right font-bold text-gray-900 dark:text-white">
                        Order Total
                    </td>
                    <td class="px-3 py-2.5 text-right font-bold text-primary-600 dark:text-primary-400 text-base">
                        Rs {{ number_format($record->total_amount, 0) }}
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
@endif
