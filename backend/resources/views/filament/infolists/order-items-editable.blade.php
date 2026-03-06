@php
    $record = $getRecord();
    $items = $record->products()->with(['product:id,name,image', 'unit:id,name'])->get();
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
                        <td class="px-3 py-2.5">
                            <div class="flex items-center gap-3">
                                @if($item->product?->image)
                                    <img
                                        src="{{ asset('storage/' . $item->product->image) }}"
                                        alt="{{ $item->product->name }}"
                                        class="w-10 h-10 rounded-lg object-cover ring-1 ring-gray-200 dark:ring-gray-700 flex-shrink-0"
                                        loading="lazy"
                                    >
                                @else
                                    <div class="w-10 h-10 rounded-lg bg-gray-100 dark:bg-gray-800 flex items-center justify-center flex-shrink-0">
                                        <svg class="w-5 h-5 text-gray-300 dark:text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                        </svg>
                                    </div>
                                @endif
                                <span class="font-medium text-gray-900 dark:text-white">
                                    {{ $item->product?->name ?? 'Unknown' }}
                                </span>
                            </div>
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
            <tfoot>
                @php
                    $subtotal = $items->sum(fn($i) => $i->price * $i->quantity);
                    $shipping = (float) ($record->shipping_amount ?? 0);
                    $couponDiscount = (float) ($record->coupon_discount ?? 0);
                    $walletUsed = (float) ($record->wallet_amount_used ?? 0);
                @endphp
                <tr class="border-t dark:border-gray-700">
                    <td colspan="5" class="px-3 py-2 text-right text-gray-500 dark:text-gray-400">Subtotal</td>
                    <td class="px-3 py-2 text-right font-medium text-gray-900 dark:text-white">Rs {{ number_format($subtotal, 0) }}</td>
                </tr>
                @if($shipping > 0)
                    <tr>
                        <td colspan="5" class="px-3 py-1.5 text-right text-gray-500 dark:text-gray-400">
                            Shipping{{ $record->shipping_title ? ' (' . $record->shipping_title . ')' : '' }}
                        </td>
                        <td class="px-3 py-1.5 text-right font-medium text-gray-900 dark:text-white">Rs {{ number_format($shipping, 0) }}</td>
                    </tr>
                @endif
                @if($couponDiscount > 0)
                    <tr>
                        <td colspan="5" class="px-3 py-1.5 text-right text-gray-500 dark:text-gray-400">
                            Coupon{{ $record->coupon_code ? ' (' . $record->coupon_code . ')' : '' }}
                        </td>
                        <td class="px-3 py-1.5 text-right font-medium text-green-600 dark:text-green-400">- Rs {{ number_format($couponDiscount, 0) }}</td>
                    </tr>
                @endif
                @if($walletUsed > 0)
                    <tr>
                        <td colspan="5" class="px-3 py-1.5 text-right text-gray-500 dark:text-gray-400">Wallet Credit</td>
                        <td class="px-3 py-1.5 text-right font-medium text-red-600 dark:text-red-400">- Rs {{ number_format($walletUsed, 0) }}</td>
                    </tr>
                @endif
                <tr class="border-t-2 dark:border-gray-600">
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
