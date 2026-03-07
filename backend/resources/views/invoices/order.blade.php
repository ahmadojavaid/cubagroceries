<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice — {{ $order->order_id }}</title>
    <style>
        /* Reset */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            color: #1a1a1a;
            background: #f0f0f0;
            line-height: 1.5;
            font-size: 14px;
        }

        /* ═══════════════════════════════════════════════
           PRINT BAR (hidden on print)
           ═══════════════════════════════════════════════ */
        .print-bar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: #1e293b;
            color: #fff;
            padding: 12px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .print-bar span { font-size: 14px; font-weight: 500; }
        .print-bar-actions { display: flex; gap: 10px; }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 18px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-print { background: #3b82f6; color: #fff; }
        .btn-print:hover { background: #2563eb; }
        .btn-thermal { background: #f59e0b; color: #fff; }
        .btn-thermal:hover { background: #d97706; }
        .btn-back { background: #374151; color: #d1d5db; }
        .btn-back:hover { background: #4b5563; }
        .btn svg { width: 16px; height: 16px; }

        /* ═══════════════════════════════════════════════
           A4 INVOICE (screen + A4 print default)
           ═══════════════════════════════════════════════ */
        .invoice {
            max-width: 800px;
            margin: 80px auto 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 10px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .invoice-header {
            background: linear-gradient(135deg, #F15722 0%, #FF7A4D 100%);
            color: #fff;
            padding: 32px 40px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .invoice-header .brand h1 { font-size: 24px; font-weight: 800; letter-spacing: -0.3px; }
        .invoice-header .brand p { font-size: 12px; opacity: 0.75; margin-top: 4px; }
        .invoice-header .invoice-meta { text-align: right; }
        .invoice-header .invoice-meta h2 { font-size: 28px; font-weight: 300; letter-spacing: 2px; text-transform: uppercase; opacity: 0.9; }
        .invoice-header .invoice-meta .order-num { font-size: 15px; font-weight: 600; margin-top: 6px; background: rgba(255,255,255,0.15); display: inline-block; padding: 3px 12px; border-radius: 4px; }
        .invoice-header .invoice-meta .date { font-size: 12px; opacity: 0.7; margin-top: 6px; }

        .invoice-body { padding: 32px 40px; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 32px; }
        .info-block .label { font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #6b7280; margin-bottom: 6px; }
        .info-block .value { font-size: 14px; color: #1f2937; }
        .info-block .value strong { font-weight: 600; }
        .info-block .value .sub { font-size: 12px; color: #6b7280; display: block; margin-top: 2px; }

        .status-badge { display: inline-block; padding: 3px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-confirmed { background: #dbeafe; color: #1e40af; }
        .status-dispatched { background: #e0e7ff; color: #3730a3; }
        .status-delivered { background: #d1fae5; color: #065f46; }
        .status-cancelled { background: #fee2e2; color: #991b1b; }

        .items-table { width: 100%; border-collapse: collapse; margin-bottom: 24px; }
        .items-table thead th { font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: #6b7280; padding: 10px 12px; border-bottom: 2px solid #e5e7eb; text-align: left; }
        .items-table thead th.num { text-align: center; }
        .items-table thead th.money { text-align: right; }
        .items-table tbody td { padding: 12px 12px; border-bottom: 1px solid #f3f4f6; vertical-align: middle; }
        .items-table tbody tr:last-child td { border-bottom: none; }
        .product-cell { display: flex; align-items: center; gap: 10px; }
        .product-img { width: 36px; height: 36px; border-radius: 6px; object-fit: cover; border: 1px solid #e5e7eb; }
        .product-img-placeholder { width: 36px; height: 36px; border-radius: 6px; background: #f3f4f6; display: flex; align-items: center; justify-content: center; }
        .product-img-placeholder svg { width: 18px; height: 18px; color: #d1d5db; }
        .product-name { font-weight: 500; color: #111827; }
        .unit-cell { color: #6b7280; font-size: 13px; }
        .qty-cell { text-align: center; font-weight: 600; }
        .price-cell { text-align: right; color: #6b7280; }
        .total-cell { text-align: right; font-weight: 600; color: #111827; }

        .totals-section { display: flex; justify-content: flex-end; }
        .totals-table { width: 280px; border-collapse: collapse; }
        .totals-table tr td { padding: 6px 0; }
        .totals-table tr td:first-child { color: #6b7280; font-size: 13px; }
        .totals-table tr td:last-child { text-align: right; font-weight: 500; }
        .totals-table .grand-total td { padding-top: 10px; border-top: 2px solid #111827; font-size: 16px; font-weight: 700; color: #111827; }
        .totals-table .grand-total td:last-child { color: #0D4F1A; }

        .invoice-footer { border-top: 1px solid #e5e7eb; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; font-size: 12px; color: #9ca3af; }
        .invoice-footer .contact span { margin-right: 16px; }

        /* ═══════════════════════════════════════════════
           THERMAL RECEIPT (hidden on screen)
           ═══════════════════════════════════════════════ */
        .receipt { display: none; }

        /* ═══════════════════════════════════════════════
           PRINT: A4 (default)
           ═══════════════════════════════════════════════ */
        @media print {
            body { background: #fff; }
            .print-bar { display: none !important; }
            .invoice { margin: 0; box-shadow: none; border-radius: 0; }
            .invoice-header { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .status-badge { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .receipt { display: none !important; }
            @page { margin: 0; size: A4; }
        }

        /* ═══════════════════════════════════════════════
           PRINT: THERMAL (activated via body.thermal)
           ═══════════════════════════════════════════════ */
        body.thermal .invoice { display: none !important; }
        body.thermal .receipt { display: block; }

        @media print {
            body.thermal .invoice { display: none !important; }
            body.thermal .receipt { display: block !important; }

            body.thermal {
                width: 72mm;
                margin: 0;
                padding: 0;
                font-family: 'Courier New', monospace;
                font-size: 11px;
                line-height: 1.3;
                color: #000;
            }

            body.thermal @page,
            @page {
                /* Override A4 — thermal printers use continuous roll */
            }
        }

        /* Thermal receipt styles (screen preview + print) */
        .receipt {
            width: 72mm;
            margin: 80px auto 40px;
            background: #fff;
            padding: 8mm 4mm;
            font-family: 'Courier New', Consolas, monospace;
            font-size: 11px;
            line-height: 1.35;
            color: #000;
            box-shadow: 0 1px 10px rgba(0,0,0,0.1);
        }

        .receipt .r-center { text-align: center; }
        .receipt .r-bold { font-weight: 700; }
        .receipt .r-line { border-top: 1px dashed #000; margin: 5px 0; }
        .receipt .r-dblline { border-top: 2px solid #000; margin: 5px 0; }
        .receipt .r-row { display: flex; justify-content: space-between; }
        .receipt .r-row-3 { display: flex; }
        .receipt .r-row-3 .r-col-name { flex: 1; }
        .receipt .r-row-3 .r-col-qty { width: 30px; text-align: center; }
        .receipt .r-row-3 .r-col-amt { width: 55px; text-align: right; }
        .receipt .r-gap { height: 4px; }
        .receipt .r-sm { font-size: 10px; }
        .receipt .r-total-row { display: flex; justify-content: space-between; font-size: 14px; font-weight: 700; }
    </style>
</head>
<body>
    <!-- ─── Print bar ────────────────────────────────── -->
    <div class="print-bar">
        <span>Invoice — {{ $order->order_id }}</span>
        <div class="print-bar-actions">
            <button class="btn btn-back" onclick="window.close()">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>
                Close
            </button>
            <button class="btn btn-thermal" onclick="printThermal()">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-3-3v6m5 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
                Thermal Print
            </button>
            <button class="btn btn-print" onclick="printA4()">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/></svg>
                Print A4 / PDF
            </button>
        </div>
    </div>

    <!-- ─── A4 Invoice (screen + A4 print) ───────────── -->
    <div class="invoice">
        <div class="invoice-header">
            <div class="brand">
                <h1>{{ $settings['app_name'] ?? 'Asif Groceries' }}</h1>
                <p>{{ $settings['contact_email'] ?? '' }}</p>
                <p>{{ $settings['contact_phone'] ?? '' }}</p>
            </div>
            <div class="invoice-meta">
                <h2>Invoice</h2>
                <div class="order-num">{{ $order->order_id }}</div>
                <div class="date">{{ $order->created_at->format('F d, Y \a\t h:i A') }}</div>
            </div>
        </div>

        <div class="invoice-body">
            <div class="info-grid">
                <div class="info-block">
                    <div class="label">Customer</div>
                    <div class="value">
                        <strong>{{ $order->user->firstname }} {{ $order->user->lastname }}</strong>
                        <span class="sub">{{ $order->user->email }}</span>
                        <span class="sub">{{ $order->user->identity }}</span>
                    </div>
                </div>
                <div class="info-block">
                    <div class="label">Delivery Address</div>
                    <div class="value">
                        @if($order->address)
                            {{ $order->address->address }}
                            @if($order->address->city)<span class="sub">{{ $order->address->city }}</span>@endif
                            @if($order->address->phone)<span class="sub">{{ $order->address->phone }}</span>@endif
                        @else
                            <span style="color:#9ca3af">No address on file</span>
                        @endif
                    </div>
                </div>
                <div class="info-block">
                    <div class="label">Status</div>
                    <div class="value">
                        <span class="status-badge status-{{ $order->status->value }}">{{ $order->status->label() }}</span>
                    </div>
                </div>
                <div class="info-block">
                    <div class="label">Delivery Boy</div>
                    <div class="value">
                        @if($order->deliveryBoy)
                            <strong>{{ $order->deliveryBoy->name }}</strong>
                            <span class="sub">{{ $order->deliveryBoy->phone }}</span>
                        @else
                            <span style="color:#9ca3af">Not assigned</span>
                        @endif
                    </div>
                </div>
            </div>

            <table class="items-table">
                <thead>
                    <tr>
                        <th style="width:30px">#</th>
                        <th>Product</th>
                        <th>Unit</th>
                        <th class="num">Qty</th>
                        <th class="money">Price</th>
                        <th class="money">Total</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($order->products as $index => $item)
                        <tr>
                            <td style="color:#9ca3af; text-align:center">{{ $index + 1 }}</td>
                            <td>
                                <div class="product-cell">
                                    @if($item->product?->image)
                                        <img src="{{ asset('storage/' . $item->product->image) }}" alt="" class="product-img">
                                    @else
                                        <div class="product-img-placeholder">
                                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                                        </div>
                                    @endif
                                    <span class="product-name">{{ $item->product?->name ?? 'Unknown' }}</span>
                                </div>
                            </td>
                            <td class="unit-cell">{{ $item->unit?->name ?? '—' }}</td>
                            <td class="qty-cell">{{ $item->quantity }}</td>
                            <td class="price-cell">Rs {{ number_format($item->price, 0) }}</td>
                            <td class="total-cell">Rs {{ number_format($item->price * $item->quantity, 0) }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>

            <div class="totals-section">
                <table class="totals-table">
                    @php
                        $subtotal = $order->products->sum(fn($i) => $i->price * $i->quantity);
                        $shipping = (float) ($order->shipping_amount ?? 0);
                        $couponDiscount = (float) ($order->coupon_discount ?? 0);
                        $walletUsed = (float) ($order->wallet_amount_used ?? 0);
                    @endphp
                    <tr><td>Subtotal</td><td>Rs {{ number_format($subtotal, 0) }}</td></tr>
                    @if($shipping > 0)
                        <tr><td>Shipping{{ $order->shipping_title ? ' (' . $order->shipping_title . ')' : '' }}</td><td>Rs {{ number_format($shipping, 0) }}</td></tr>
                    @endif
                    @if($couponDiscount > 0)
                        <tr><td>Promo Code ({{ $order->coupon_code }})</td><td style="color:#16a34a">- Rs {{ number_format($couponDiscount, 0) }}</td></tr>
                    @endif
                    @if($walletUsed > 0)
                        <tr><td>Wallet Credit</td><td style="color:#dc2626">- Rs {{ number_format($walletUsed, 0) }}</td></tr>
                    @endif
                    <tr class="grand-total"><td>Total</td><td>Rs {{ number_format($order->total_amount, 0) }}</td></tr>
                </table>
            </div>
        </div>

        <div class="invoice-footer">
            <div class="contact">
                <span>{{ $settings['contact_email'] ?? '' }}</span>
                <span>{{ $settings['contact_phone'] ?? '' }}</span>
            </div>
            <div>Generated on {{ now()->format('M d, Y H:i') }}</div>
        </div>
    </div>

    <!-- ─── Thermal Receipt (hidden on screen, shown for thermal print) ─── -->
    @php
        $subtotal = $order->products->sum(fn($i) => $i->price * $i->quantity);
        $shipping = (float) ($order->shipping_amount ?? 0);
        $couponDiscount = (float) ($order->coupon_discount ?? 0);
        $walletUsed = (float) ($order->wallet_amount_used ?? 0);
    @endphp
    <div class="receipt">
        {{-- Store name --}}
        <div class="r-center r-bold" style="font-size:14px;">{{ $settings['app_name'] ?? 'Asif Groceries' }}</div>
        @if(!empty($settings['contact_phone']))
            <div class="r-center r-sm">{{ $settings['contact_phone'] }}</div>
        @endif
        <div class="r-line"></div>

        {{-- Order info --}}
        <div class="r-row"><span>Order #</span><span class="r-bold">{{ $order->order_id }}</span></div>
        <div class="r-row"><span>Date</span><span>{{ $order->created_at->format('d M Y, h:i A') }}</span></div>
        <div class="r-row"><span>Status</span><span>{{ $order->status->label() }}</span></div>
        <div class="r-line"></div>

        {{-- Customer --}}
        <div class="r-sm r-bold">Customer</div>
        <div>{{ $order->user->firstname }} {{ $order->user->lastname }}</div>
        @if($order->user->identity)
            <div class="r-sm">{{ $order->user->identity }}</div>
        @endif
        @if($order->address)
            <div class="r-gap"></div>
            <div class="r-sm r-bold">Delivery Address</div>
            <div class="r-sm">{{ $order->address->address }}</div>
            @if($order->address->city)<div class="r-sm">{{ $order->address->city }}</div>@endif
            @if($order->address->phone)<div class="r-sm">Ph: {{ $order->address->phone }}</div>@endif
        @endif
        @if($order->deliveryBoy)
            <div class="r-gap"></div>
            <div class="r-sm">Rider: {{ $order->deliveryBoy->name }} ({{ $order->deliveryBoy->phone }})</div>
        @endif
        <div class="r-dblline"></div>

        {{-- Column headers --}}
        <div class="r-row-3 r-bold r-sm">
            <div class="r-col-name">Item</div>
            <div class="r-col-qty">Qty</div>
            <div class="r-col-amt">Amount</div>
        </div>
        <div class="r-line"></div>

        {{-- Items --}}
        @foreach($order->products as $item)
            <div class="r-row-3">
                <div class="r-col-name">{{ $item->product?->name ?? '?' }}</div>
                <div class="r-col-qty">{{ $item->quantity }}</div>
                <div class="r-col-amt">{{ number_format($item->price * $item->quantity, 0) }}</div>
            </div>
            <div class="r-sm" style="color:#555; padding-left:2px;">
                {{ $item->quantity }} x Rs {{ number_format($item->price, 0) }}/{{ $item->unit?->name ?? '' }}
            </div>
        @endforeach
        <div class="r-dblline"></div>

        {{-- Totals --}}
        <div class="r-row"><span>Subtotal</span><span>Rs {{ number_format($subtotal, 0) }}</span></div>
        @if($shipping > 0)
            <div class="r-row"><span>Shipping</span><span>Rs {{ number_format($shipping, 0) }}</span></div>
        @endif
        @if($couponDiscount > 0)
            <div class="r-row"><span>Coupon ({{ $order->coupon_code }})</span><span>-Rs {{ number_format($couponDiscount, 0) }}</span></div>
        @endif
        @if($walletUsed > 0)
            <div class="r-row"><span>Wallet</span><span>-Rs {{ number_format($walletUsed, 0) }}</span></div>
        @endif
        <div class="r-line"></div>
        <div class="r-total-row">
            <span>TOTAL</span>
            <span>Rs {{ number_format($order->total_amount, 0) }}</span>
        </div>
        <div class="r-dblline"></div>

        {{-- Footer --}}
        <div class="r-gap"></div>
        <div class="r-center r-sm">Thank you for your order!</div>
        <div class="r-center r-sm">{{ $settings['contact_email'] ?? '' }}</div>
        <div class="r-gap"></div>
        <div class="r-center r-sm" style="color:#888;">{{ now()->format('d/m/Y H:i') }}</div>
        <div class="r-gap"></div>
    </div>

    <script>
        function printA4() {
            document.body.classList.remove('thermal');
            // Small delay to let repaint happen
            setTimeout(() => window.print(), 50);
        }

        function printThermal() {
            document.body.classList.add('thermal');
            setTimeout(() => {
                window.print();
                // Remove class after print dialog closes
                setTimeout(() => document.body.classList.remove('thermal'), 500);
            }, 50);
        }
    </script>
</body>
</html>
