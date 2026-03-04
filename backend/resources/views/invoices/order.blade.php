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

        /* Print bar (hidden on print) */
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
        .btn-print {
            background: #3b82f6;
            color: #fff;
        }
        .btn-print:hover { background: #2563eb; }
        .btn-back {
            background: #374151;
            color: #d1d5db;
        }
        .btn-back:hover { background: #4b5563; }
        .btn svg { width: 16px; height: 16px; }

        /* Invoice container */
        .invoice {
            max-width: 800px;
            margin: 80px auto 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 10px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        /* Header */
        .invoice-header {
            background: linear-gradient(135deg, #0D4F1A 0%, #1B6B2A 100%);
            color: #fff;
            padding: 32px 40px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .invoice-header .brand h1 {
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.3px;
        }
        .invoice-header .brand p {
            font-size: 12px;
            opacity: 0.75;
            margin-top: 4px;
        }
        .invoice-header .invoice-meta {
            text-align: right;
        }
        .invoice-header .invoice-meta h2 {
            font-size: 28px;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
            opacity: 0.9;
        }
        .invoice-header .invoice-meta .order-num {
            font-size: 15px;
            font-weight: 600;
            margin-top: 6px;
            background: rgba(255,255,255,0.15);
            display: inline-block;
            padding: 3px 12px;
            border-radius: 4px;
        }
        .invoice-header .invoice-meta .date {
            font-size: 12px;
            opacity: 0.7;
            margin-top: 6px;
        }

        /* Body */
        .invoice-body { padding: 32px 40px; }

        /* Info grid */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
        }
        .info-block {}
        .info-block .label {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6b7280;
            margin-bottom: 6px;
        }
        .info-block .value {
            font-size: 14px;
            color: #1f2937;
        }
        .info-block .value strong { font-weight: 600; }
        .info-block .value .sub {
            font-size: 12px;
            color: #6b7280;
            display: block;
            margin-top: 2px;
        }

        /* Status badge */
        .status-badge {
            display: inline-block;
            padding: 3px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-confirmed { background: #dbeafe; color: #1e40af; }
        .status-dispatched { background: #e0e7ff; color: #3730a3; }
        .status-delivered { background: #d1fae5; color: #065f46; }
        .status-cancelled { background: #fee2e2; color: #991b1b; }

        /* Table */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }
        .items-table thead th {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: #6b7280;
            padding: 10px 12px;
            border-bottom: 2px solid #e5e7eb;
            text-align: left;
        }
        .items-table thead th.num { text-align: center; }
        .items-table thead th.money { text-align: right; }
        .items-table tbody td {
            padding: 12px 12px;
            border-bottom: 1px solid #f3f4f6;
            vertical-align: middle;
        }
        .items-table tbody tr:last-child td { border-bottom: none; }
        .product-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .product-img {
            width: 36px;
            height: 36px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #e5e7eb;
        }
        .product-img-placeholder {
            width: 36px;
            height: 36px;
            border-radius: 6px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-img-placeholder svg { width: 18px; height: 18px; color: #d1d5db; }
        .product-name { font-weight: 500; color: #111827; }
        .unit-cell { color: #6b7280; font-size: 13px; }
        .qty-cell { text-align: center; font-weight: 600; }
        .price-cell { text-align: right; color: #6b7280; }
        .total-cell { text-align: right; font-weight: 600; color: #111827; }

        /* Totals */
        .totals-section {
            display: flex;
            justify-content: flex-end;
        }
        .totals-table {
            width: 280px;
            border-collapse: collapse;
        }
        .totals-table tr td {
            padding: 6px 0;
        }
        .totals-table tr td:first-child {
            color: #6b7280;
            font-size: 13px;
        }
        .totals-table tr td:last-child {
            text-align: right;
            font-weight: 500;
        }
        .totals-table .grand-total td {
            padding-top: 10px;
            border-top: 2px solid #111827;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }
        .totals-table .grand-total td:last-child {
            color: #0D4F1A;
        }

        /* Footer */
        .invoice-footer {
            border-top: 1px solid #e5e7eb;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: #9ca3af;
        }
        .invoice-footer .contact span { margin-right: 16px; }

        /* Print styles */
        @media print {
            body { background: #fff; }
            .print-bar { display: none !important; }
            .invoice {
                margin: 0;
                box-shadow: none;
                border-radius: 0;
            }
            .invoice-header {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
            .status-badge {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
            @page {
                margin: 0;
                size: A4;
            }
        }
    </style>
</head>
<body>
    <!-- Print bar -->
    <div class="print-bar">
        <span>Invoice — {{ $order->order_id }}</span>
        <div class="print-bar-actions">
            <button class="btn btn-back" onclick="window.close()">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>
                Close
            </button>
            <button class="btn btn-print" onclick="window.print()">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/></svg>
                Print / Save PDF
            </button>
        </div>
    </div>

    <!-- Invoice -->
    <div class="invoice">
        <!-- Header -->
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

        <!-- Body -->
        <div class="invoice-body">
            <!-- Info grid -->
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
                            @if($order->address->city)
                                <span class="sub">{{ $order->address->city }}</span>
                            @endif
                            @if($order->address->phone)
                                <span class="sub">{{ $order->address->phone }}</span>
                            @endif
                        @else
                            <span style="color:#9ca3af">No address on file</span>
                        @endif
                    </div>
                </div>

                <div class="info-block">
                    <div class="label">Status</div>
                    <div class="value">
                        <span class="status-badge status-{{ $order->status->value }}">
                            {{ $order->status->label() }}
                        </span>
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

            <!-- Items table -->
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

            <!-- Totals -->
            <div class="totals-section">
                <table class="totals-table">
                    @php
                        $subtotal = $order->products->sum(fn($i) => $i->price * $i->quantity);
                        $walletUsed = (float) ($order->wallet_amount_used ?? 0);
                    @endphp
                    <tr>
                        <td>Subtotal</td>
                        <td>Rs {{ number_format($subtotal, 0) }}</td>
                    </tr>
                    @if($walletUsed > 0)
                        <tr>
                            <td>Wallet Credit</td>
                            <td style="color:#dc2626">- Rs {{ number_format($walletUsed, 0) }}</td>
                        </tr>
                    @endif
                    <tr class="grand-total">
                        <td>Total</td>
                        <td>Rs {{ number_format($order->total_amount, 0) }}</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <div class="invoice-footer">
            <div class="contact">
                <span>{{ $settings['contact_email'] ?? '' }}</span>
                <span>{{ $settings['contact_phone'] ?? '' }}</span>
            </div>
            <div>
                Generated on {{ now()->format('M d, Y H:i') }}
            </div>
        </div>
    </div>
</body>
</html>
