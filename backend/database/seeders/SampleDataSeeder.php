<?php

namespace Database\Seeders;

use App\Enums\OrderStatus;
use App\Models\Address;
use App\Models\Complaint;
use App\Models\Coupon;
use App\Models\DeliveryBoy;
use App\Models\Order;
use App\Models\OrderAddress;
use App\Models\Orderproduct;
use App\Models\Price;
use App\Models\Product;
use App\Models\Review;
use App\Models\ShippingCharge;
use App\Models\AppSetting;
use App\Models\Faq;
use App\Models\SearchHistory;
use App\Models\StoreSchedule;
use App\Models\User;
use App\Notifications\OrderStatusChanged;
use Illuminate\Database\Seeder;

class SampleDataSeeder extends Seeder
{
    public function run(): void
    {
        $this->command->info('Seeding sample data...');

        $this->seedShippingCharges();
        $this->command->info('  ✓ Shipping charges');

        $this->seedDeliveryBoys();
        $this->command->info('  ✓ Delivery boys');

        $customers = $this->seedCustomers();
        $this->command->info('  ✓ Customers (' . count($customers) . ')');

        $this->seedAddresses($customers);
        $this->command->info('  ✓ Addresses');

        $this->seedOrders($customers);
        $this->command->info('  ✓ Orders with items & addresses');

        $this->seedOrderStatusHistory();
        $this->command->info('  ✓ Order status history');

        $this->seedWalletTransactions($customers);
        $this->command->info('  ✓ Wallet transactions');

        $this->seedComplaints($customers);
        $this->command->info('  ✓ Complaints');

        $this->seedNotifications($customers);
        $this->command->info('  ✓ Notifications');

        $this->seedStoreSchedules();
        $this->command->info('  ✓ Store schedules');

        $this->seedCoupons($customers);
        $this->command->info('  ✓ Coupons');

        $this->seedReviews($customers);
        $this->command->info('  ✓ Reviews');

        $this->seedFaqs();
        $this->command->info('  ✓ FAQs');

        $this->seedSearchHistory($customers);
        $this->command->info('  ✓ Search history');

        $this->seedAppSettings();
        $this->command->info('  ✓ App settings');

        $this->command->info('Sample data seeding complete!');
    }

    private function seedShippingCharges(): void
    {
        $charges = [
            ['title' => 'Standard Delivery', 'amount' => 100.00, 'min_order_amount' => null],
            ['title' => 'Express Delivery', 'amount' => 200.00, 'min_order_amount' => null],
            ['title' => 'Free Delivery (Rs 2000+)', 'amount' => 0.00, 'min_order_amount' => 2000.00],
        ];

        foreach ($charges as $charge) {
            ShippingCharge::firstOrCreate(['title' => $charge['title']], $charge);
        }
    }

    private function seedDeliveryBoys(): void
    {
        $riders = [
            ['name' => 'Ahmed Raza', 'phone' => '03001234567', 'payment' => 15000],
            ['name' => 'Bilal Khan', 'phone' => '03009876543', 'payment' => 12500],
            ['name' => 'Hamza Ali', 'phone' => '03211234567', 'payment' => 8000],
        ];

        foreach ($riders as $rider) {
            DeliveryBoy::firstOrCreate(['phone' => $rider['phone']], $rider);
        }
    }

    /**
     * @return User[]
     */
    private function seedCustomers(): array
    {
        $customers = [
            [
                'identity' => '03001112233',
                'email' => 'ali@example.com',
                'firstname' => 'Ali',
                'lastname' => 'Khan',
                'password' => 'password',
                'date_of_birth' => '1995-06-15',
                'wallet_amount' => 500.00,
                'role' => 'customer',
            ],
            [
                'identity' => '03004445566',
                'email' => 'sara@example.com',
                'firstname' => 'Sara',
                'lastname' => 'Ahmed',
                'password' => 'password',
                'date_of_birth' => now()->format('Y-m-d'), // birthday today!
                'wallet_amount' => 1200.00,
                'role' => 'customer',
            ],
            [
                'identity' => '03007778899',
                'email' => 'usman@example.com',
                'firstname' => 'Usman',
                'lastname' => 'Malik',
                'password' => 'password',
                'date_of_birth' => '1990-03-22',
                'wallet_amount' => 0.00,
                'role' => 'customer',
            ],
            [
                'identity' => '03212223344',
                'email' => 'fatima@example.com',
                'firstname' => 'Fatima',
                'lastname' => 'Noor',
                'password' => 'password',
                'date_of_birth' => '1998-11-08',
                'wallet_amount' => 350.00,
                'role' => 'customer',
            ],
            [
                'identity' => '03335556677',
                'email' => 'hassan@example.com',
                'firstname' => 'Hassan',
                'lastname' => 'Raza',
                'password' => 'password',
                'date_of_birth' => '1992-01-30',
                'wallet_amount' => 2000.00,
                'role' => 'customer',
            ],
        ];

        $result = [];
        foreach ($customers as $data) {
            $result[] = User::firstOrCreate(
                ['email' => $data['email']],
                $data
            );
        }

        // Rider user — linked to delivery boy Ahmed Raza
        $riderUser = User::firstOrCreate(
            ['email' => 'rider@cubagroceries.test'],
            [
                'identity' => '03451234567',
                'firstname' => 'Ahmed',
                'lastname' => 'Rider',
                'password' => 'password',
                'wallet_amount' => 0,
                'role' => 'rider',
            ]
        );

        // Link rider to delivery boy
        $ahmed = DeliveryBoy::where('phone', '03001234567')->first();
        if ($ahmed && !$ahmed->user_id) {
            $ahmed->update(['user_id' => $riderUser->id]);
        }

        return $result;
    }

    private function seedAddresses(array $customers): void
    {
        $addressData = [
            // Ali Khan — 2 addresses
            [
                ['label' => 'Home', 'address' => '123 Main Boulevard, Gulberg III', 'city' => 'Lahore', 'phone' => '03001112233', 'is_default' => true, 'latitude' => 31.5204, 'longitude' => 74.3587],
                ['label' => 'Office', 'address' => '45 Liberty Market, Floor 2', 'city' => 'Lahore', 'phone' => '03001112233', 'is_default' => false, 'latitude' => 31.5150, 'longitude' => 74.3477],
            ],
            // Sara Ahmed
            [
                ['label' => 'Home', 'address' => '78 DHA Phase 5, Block D', 'city' => 'Lahore', 'phone' => '03004445566', 'is_default' => true, 'latitude' => 31.4697, 'longitude' => 74.3762],
            ],
            // Usman Malik
            [
                ['label' => 'Home', 'address' => '22 Johar Town, Block E', 'city' => 'Lahore', 'phone' => '03007778899', 'is_default' => true, 'latitude' => 31.4618, 'longitude' => 74.2725],
                ['label' => 'Mom\'s House', 'address' => '90 Model Town, Block C', 'city' => 'Lahore', 'phone' => '03007778899', 'is_default' => false, 'latitude' => 31.4833, 'longitude' => 74.3155],
            ],
            // Fatima Noor
            [
                ['label' => 'Home', 'address' => '15 Bahria Town, Sector B', 'city' => 'Lahore', 'phone' => '03212223344', 'is_default' => true, 'latitude' => 31.3674, 'longitude' => 74.1810],
            ],
            // Hassan Raza
            [
                ['label' => 'Home', 'address' => '55 Garden Town, Block A', 'city' => 'Lahore', 'phone' => '03335556677', 'is_default' => true, 'latitude' => 31.5090, 'longitude' => 74.3363],
            ],
        ];

        foreach ($customers as $i => $customer) {
            if (!isset($addressData[$i])) continue;
            foreach ($addressData[$i] as $addr) {
                Address::firstOrCreate(
                    ['user_id' => $customer->id, 'label' => $addr['label']],
                    array_merge($addr, ['user_id' => $customer->id])
                );
            }
        }
    }

    private function seedOrders(array $customers): void
    {
        $products = Product::with('prices.unit')->get();
        $deliveryBoys = DeliveryBoy::all();

        if ($products->isEmpty()) {
            $this->command->warn('  ⚠ No products found — skipping orders');
            return;
        }

        $ordersConfig = [
            // Ali Khan — 4 orders (various statuses)
            ['customer' => 0, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 3, 'days_ago' => 15, 'wallet_used' => 0],
            ['customer' => 0, 'status' => OrderStatus::Dispatched, 'rider' => 1, 'items' => 2, 'days_ago' => 2, 'wallet_used' => 0],
            ['customer' => 0, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 4, 'days_ago' => 0, 'wallet_used' => 0],
            ['customer' => 0, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 2, 'days_ago' => 25, 'wallet_used' => 200],

            // Sara Ahmed — 3 orders
            ['customer' => 1, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 2, 'days_ago' => 10, 'wallet_used' => 0],
            ['customer' => 1, 'status' => OrderStatus::Confirmed, 'rider' => null, 'items' => 3, 'days_ago' => 1, 'wallet_used' => 500],
            ['customer' => 1, 'status' => OrderStatus::Delivered, 'rider' => 2, 'items' => 2, 'days_ago' => 18, 'wallet_used' => 0],

            // Usman Malik — 3 orders
            ['customer' => 2, 'status' => OrderStatus::Delivered, 'rider' => 2, 'items' => 5, 'days_ago' => 20, 'wallet_used' => 0],
            ['customer' => 2, 'status' => OrderStatus::Cancelled, 'rider' => null, 'items' => 1, 'days_ago' => 5, 'wallet_used' => 0],
            ['customer' => 2, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 3, 'days_ago' => 0, 'wallet_used' => 0],

            // Fatima Noor — 3 orders
            ['customer' => 3, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 2, 'days_ago' => 0, 'wallet_used' => 0],
            ['customer' => 3, 'status' => OrderStatus::Delivered, 'rider' => 1, 'items' => 3, 'days_ago' => 8, 'wallet_used' => 150],
            ['customer' => 3, 'status' => OrderStatus::Dispatched, 'rider' => 0, 'items' => 2, 'days_ago' => 1, 'wallet_used' => 0],

            // Hassan Raza — 4 orders
            ['customer' => 4, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 4, 'days_ago' => 12, 'wallet_used' => 300],
            ['customer' => 4, 'status' => OrderStatus::Dispatched, 'rider' => 2, 'items' => 2, 'days_ago' => 1, 'wallet_used' => 0],
            ['customer' => 4, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 3, 'days_ago' => 0, 'wallet_used' => 0],
            ['customer' => 4, 'status' => OrderStatus::Delivered, 'rider' => 1, 'items' => 5, 'days_ago' => 30, 'wallet_used' => 1000],
        ];

        foreach ($ordersConfig as $config) {
            $customer = $customers[$config['customer']];
            $address = $customer->addresses()->first();
            if (!$address) continue;

            // Pick random products
            $orderProducts = $products->random(min($config['items'], $products->count()));
            $totalAmount = 0;
            $lineItems = [];

            foreach ($orderProducts as $product) {
                $price = $product->prices->first();
                if (!$price) continue;
                $qty = rand(1, 5);
                $lineTotal = $price->price * $qty;
                $totalAmount += $lineTotal;

                $lineItems[] = [
                    'product_id' => $product->id,
                    'unit_id' => $price->unit_id,
                    'quantity' => $qty,
                    'price' => $price->price,
                ];
            }

            if (empty($lineItems)) continue;

            $walletUsed = min($config['wallet_used'], $totalAmount);
            $orderNumber = 'CUBA' . str_pad(rand(10000000, 99999999), 8, '0', STR_PAD_LEFT);
            $createdAt = now()->subDays($config['days_ago'])->subHours(rand(0, 12));

            $orderData = [
                'order_id' => $orderNumber,
                'user_id' => $customer->id,
                'status' => $config['status'],
                'total_amount' => $totalAmount,
                'delivery_boy_id' => $config['rider'] !== null ? $deliveryBoys[$config['rider']]->id : null,
                'created_at' => $createdAt,
                'updated_at' => $createdAt,
            ];

            // Add wallet_amount_used if column exists
            if (\Schema::hasColumn('orderdetails', 'wallet_amount_used')) {
                $orderData['wallet_amount_used'] = $walletUsed;
            }

            // Add estimated delivery if column exists and order is active
            if (\Schema::hasColumn('orderdetails', 'est_delivery_minutes') && !in_array($config['status'], [OrderStatus::Delivered, OrderStatus::Cancelled])) {
                $orderData['est_delivery_minutes'] = rand(30, 90);
                $orderData['est_delivery_set_at'] = $createdAt;
            }

            $order = Order::create($orderData);

            // Order address snapshot
            OrderAddress::create([
                'order_id' => $order->id,
                'address' => $address->address,
                'city' => $address->city,
                'phone' => $address->phone,
                'latitude' => $address->latitude,
                'longitude' => $address->longitude,
            ]);

            // Order line items
            foreach ($lineItems as $item) {
                Orderproduct::create(array_merge($item, ['order_id' => $order->id]));
            }
        }
    }

    private function seedOrderStatusHistory(): void
    {
        if (!\Schema::hasTable('order_status_history')) return;

        $orders = Order::all();

        foreach ($orders as $order) {
            $statuses = $this->getStatusTrail($order->status);
            $time = $order->created_at->copy();

            foreach ($statuses as $i => $status) {
                \DB::table('order_status_history')->insert([
                    'order_id' => $order->id,
                    'status' => $status,
                    'changed_by' => $i === 0 ? 'system' : 'admin',
                    'created_at' => $time,
                    'updated_at' => $time,
                ]);
                $time = $time->copy()->addMinutes(rand(10, 120));
            }
        }
    }

    private function getStatusTrail(OrderStatus $currentStatus): array
    {
        return match ($currentStatus) {
            OrderStatus::Pending => [OrderStatus::Pending],
            OrderStatus::Confirmed => [OrderStatus::Pending, OrderStatus::Confirmed],
            OrderStatus::Dispatched => [OrderStatus::Pending, OrderStatus::Confirmed, OrderStatus::Dispatched],
            OrderStatus::Delivered => [OrderStatus::Pending, OrderStatus::Confirmed, OrderStatus::Dispatched, OrderStatus::Delivered],
            OrderStatus::Cancelled => [OrderStatus::Pending, OrderStatus::Cancelled],
        };
    }

    private function seedWalletTransactions(array $customers): void
    {
        if (!\Schema::hasTable('wallet_transactions')) return;

        $txnData = [
            // Ali: Rs 500 balance — topped up Rs 1000, used Rs 200 on order, used Rs 300 on another
            [
                'customer' => 0,
                'transactions' => [
                    ['type' => 'credit', 'amount' => 1000, 'balance_after' => 1000, 'source' => 'admin_topup', 'note' => 'Welcome bonus', 'days_ago' => 30],
                    ['type' => 'debit', 'amount' => 200, 'balance_after' => 800, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 25],
                    ['type' => 'debit', 'amount' => 300, 'balance_after' => 500, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 10],
                ],
            ],
            // Sara: Rs 1200 balance — topped up Rs 2000, used Rs 500, got Rs 200 refund, used Rs 500
            [
                'customer' => 1,
                'transactions' => [
                    ['type' => 'credit', 'amount' => 2000, 'balance_after' => 2000, 'source' => 'admin_topup', 'note' => 'Loyalty bonus', 'days_ago' => 25],
                    ['type' => 'debit', 'amount' => 500, 'balance_after' => 1500, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 18],
                    ['type' => 'credit', 'amount' => 200, 'balance_after' => 1700, 'source' => 'order_refund', 'note' => 'Refund for damaged items', 'days_ago' => 15],
                    ['type' => 'debit', 'amount' => 500, 'balance_after' => 1200, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 1],
                ],
            ],
            // Fatima: Rs 350 balance — topped up Rs 500, used Rs 150
            [
                'customer' => 3,
                'transactions' => [
                    ['type' => 'credit', 'amount' => 500, 'balance_after' => 500, 'source' => 'admin_topup', 'note' => 'Wallet top-up', 'days_ago' => 20],
                    ['type' => 'debit', 'amount' => 150, 'balance_after' => 350, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 8],
                ],
            ],
            // Hassan: Rs 2000 balance — topped up Rs 3300, used Rs 1300
            [
                'customer' => 4,
                'transactions' => [
                    ['type' => 'credit', 'amount' => 3000, 'balance_after' => 3000, 'source' => 'admin_topup', 'note' => 'Bulk top-up', 'days_ago' => 35],
                    ['type' => 'debit', 'amount' => 1000, 'balance_after' => 2000, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 30],
                    ['type' => 'credit', 'amount' => 300, 'balance_after' => 2300, 'source' => 'order_refund', 'note' => 'Partial refund', 'days_ago' => 20],
                    ['type' => 'debit', 'amount' => 300, 'balance_after' => 2000, 'source' => 'order_payment', 'note' => 'Order payment', 'days_ago' => 12],
                ],
            ],
        ];

        foreach ($txnData as $data) {
            $customer = $customers[$data['customer']];
            foreach ($data['transactions'] as $txn) {
                \DB::table('wallet_transactions')->insert([
                    'user_id' => $customer->id,
                    'type' => $txn['type'],
                    'amount' => $txn['amount'],
                    'balance_after' => $txn['balance_after'],
                    'source' => $txn['source'],
                    'note' => $txn['note'],
                    'created_at' => now()->subDays($txn['days_ago']),
                    'updated_at' => now()->subDays($txn['days_ago']),
                ]);
            }
        }
    }

    private function seedComplaints(array $customers): void
    {
        $complaints = [
            [
                'customer' => 0,
                'subject' => 'Missing items in my order',
                'message' => 'I ordered 5 items but only received 3. The tomatoes and onions were missing from my delivery. Please look into this.',
                'status' => 'pending',
            ],
            [
                'customer' => 1,
                'subject' => 'Late delivery',
                'message' => 'My order was supposed to arrive within 2 hours but it took almost 5 hours. The delivery boy was not reachable on phone.',
                'status' => 'in_progress',
            ],
            [
                'customer' => 2,
                'subject' => 'Damaged products',
                'message' => 'The eggs I received were broken. At least 4 out of 12 were cracked. I need a refund or replacement.',
                'status' => 'resolved',
            ],
            [
                'customer' => 4,
                'subject' => 'Wrong items delivered',
                'message' => 'I ordered Sindhri mangoes but received some other variety. These don\'t look or taste like what I ordered.',
                'status' => 'pending',
            ],
            [
                'customer' => 3,
                'subject' => 'App showing wrong prices',
                'message' => 'The price shown for Fresh Milk in the app was Rs 180 but I was charged Rs 220. Please check the pricing.',
                'status' => 'closed',
            ],
        ];

        foreach ($complaints as $data) {
            $customer = $customers[$data['customer']];
            $order = $customer->orders()->first();

            Complaint::firstOrCreate(
                ['user_id' => $customer->id, 'subject' => $data['subject']],
                [
                    'user_id' => $customer->id,
                    'order_id' => $order?->id,
                    'subject' => $data['subject'],
                    'message' => $data['message'],
                    'status' => $data['status'],
                ]
            );
        }
    }

    private function seedStoreSchedules(): void
    {
        $schedules = [
            ['day' => 'monday',    'open_time' => '09:00', 'close_time' => '21:00', 'is_closed' => false],
            ['day' => 'tuesday',   'open_time' => '09:00', 'close_time' => '21:00', 'is_closed' => false],
            ['day' => 'wednesday', 'open_time' => '09:00', 'close_time' => '21:00', 'is_closed' => false],
            ['day' => 'thursday',  'open_time' => '09:00', 'close_time' => '21:00', 'is_closed' => false],
            ['day' => 'friday',    'open_time' => '14:00', 'close_time' => '21:00', 'is_closed' => false],
            ['day' => 'saturday',  'open_time' => '10:00', 'close_time' => '22:00', 'is_closed' => false],
            ['day' => 'sunday',    'open_time' => '00:00', 'close_time' => '00:00', 'is_closed' => true],
        ];

        foreach ($schedules as $schedule) {
            StoreSchedule::firstOrCreate(['day' => $schedule['day']], $schedule);
        }
    }

    private function seedCoupons(array $customers): void
    {
        $coupons = [
            [
                'code' => 'WELCOME10',
                'description' => '10% off your first order',
                'type' => 'percentage',
                'value' => 10,
                'min_order_amount' => 500,
                'max_discount' => 200,
                'usage_limit' => 100,
                'used_count' => 12,
                'start_date' => now()->subDays(30),
                'end_date' => now()->addDays(60),
                'is_active' => true,
            ],
            [
                'code' => 'FLAT50',
                'description' => 'Rs 50 off on orders above Rs 1000',
                'type' => 'fixed',
                'value' => 50,
                'min_order_amount' => 1000,
                'max_discount' => null,
                'usage_limit' => null,
                'used_count' => 35,
                'start_date' => now()->subDays(15),
                'end_date' => now()->addDays(15),
                'is_active' => true,
            ],
            [
                'code' => 'SUMMER25',
                'description' => '25% off summer beverages',
                'type' => 'percentage',
                'value' => 25,
                'min_order_amount' => 300,
                'max_discount' => 500,
                'usage_limit' => 50,
                'used_count' => 50,
                'start_date' => now()->subDays(60),
                'end_date' => now()->subDays(5),
                'is_active' => false,
            ],
            [
                'code' => 'FREEDEL',
                'description' => 'Free delivery on orders above Rs 300',
                'type' => 'free_delivery',
                'value' => 200,
                'min_order_amount' => 300,
                'max_discount' => null,
                'usage_limit' => 200,
                'used_count' => 78,
                'start_date' => now()->subDays(10),
                'end_date' => now()->addDays(90),
                'is_active' => true,
            ],
            [
                'code' => 'VIP100',
                'description' => 'Rs 100 off — exclusive for Hassan',
                'type' => 'fixed',
                'value' => 100,
                'min_order_amount' => 500,
                'max_discount' => null,
                'usage_limit' => 5,
                'used_count' => 0,
                'start_date' => now()->subDays(5),
                'end_date' => now()->addDays(30),
                'is_active' => true,
                'user_id' => $customers[4]->id, // Hassan
            ],
        ];

        foreach ($coupons as $coupon) {
            Coupon::firstOrCreate(['code' => $coupon['code']], $coupon);
        }
    }

    private function seedReviews(array $customers): void
    {
        $products = Product::all();
        if ($products->isEmpty()) return;

        $reviews = [
            ['customer' => 0, 'rating' => 5, 'comment' => 'Best oranges I\'ve ever had. Super fresh and juicy!', 'status' => 'approved'],
            ['customer' => 0, 'rating' => 4, 'comment' => 'Good quality tomatoes, but a couple were slightly soft.', 'status' => 'approved'],
            ['customer' => 1, 'rating' => 5, 'comment' => 'The mangoes are absolutely amazing. Will order again!', 'status' => 'approved'],
            ['customer' => 1, 'rating' => 3, 'comment' => 'Milk was close to expiry date. Expected better.', 'status' => 'approved'],
            ['customer' => 2, 'rating' => 2, 'comment' => 'Bananas arrived too green, not ripe at all.', 'status' => 'approved'],
            ['customer' => 2, 'rating' => 4, 'comment' => null, 'status' => 'approved'],
            ['customer' => 3, 'rating' => 5, 'comment' => 'Fresh vegetables, excellent packaging!', 'status' => 'pending'],
            ['customer' => 3, 'rating' => 1, 'comment' => 'Received wrong product. Very disappointed.', 'status' => 'pending'],
            ['customer' => 4, 'rating' => 4, 'comment' => 'Good cheddar cheese, nice taste.', 'status' => 'approved'],
            ['customer' => 4, 'rating' => 5, 'comment' => 'Orange juice is top quality. My kids love it.', 'status' => 'approved'],
            ['customer' => 0, 'rating' => 3, 'comment' => 'Cola was a bit flat, packaging could be better.', 'status' => 'rejected'],
            ['customer' => 2, 'rating' => 4, 'comment' => 'Carrots were very fresh and crunchy.', 'status' => 'pending'],
        ];

        foreach ($reviews as $i => $data) {
            $customer = $customers[$data['customer']];
            $product = $products[$i % $products->count()];
            $order = $customer->orders()->first();

            Review::firstOrCreate(
                ['user_id' => $customer->id, 'product_id' => $product->id],
                [
                    'user_id' => $customer->id,
                    'product_id' => $product->id,
                    'order_id' => $order?->id,
                    'rating' => $data['rating'],
                    'comment' => $data['comment'],
                    'status' => $data['status'],
                    'created_at' => now()->subDays(rand(1, 30)),
                ]
            );
        }
    }

    private function seedNotifications(array $customers): void
    {
        $orders = Order::whereIn('status', [
            OrderStatus::Delivered,
            OrderStatus::Dispatched,
            OrderStatus::Confirmed,
        ])->with('user')->get();

        foreach ($orders as $order) {
            $previousStatus = match ($order->status) {
                OrderStatus::Confirmed => OrderStatus::Pending,
                OrderStatus::Dispatched => OrderStatus::Confirmed,
                OrderStatus::Delivered => OrderStatus::Dispatched,
                default => OrderStatus::Pending,
            };

            $existingCount = $order->user->notifications()->count();
            if ($existingCount >= 6) continue;

            $order->user->notify(new OrderStatusChanged($order, $previousStatus, $order->status));
        }

        // Mark some as read
        foreach ($customers as $customer) {
            $customer->notifications()->limit(2)->update(['read_at' => now()]);
        }
    }

    private function seedFaqs(): void
    {
        $faqs = [
            [
                'question' => 'How do I place an order?',
                'answer' => 'Browse products, add items to your cart, proceed to checkout, select your delivery address and shipping method, then confirm your order.',
                'sort_order' => 1,
            ],
            [
                'question' => 'What are the delivery hours?',
                'answer' => 'We deliver Monday to Saturday from 9 AM to 9 PM. Friday deliveries start at 2 PM. We are closed on Sundays.',
                'sort_order' => 2,
            ],
            [
                'question' => 'How can I track my order?',
                'answer' => 'Go to My Orders in the app to see the current status of your order. You will also receive push notifications when your order status changes.',
                'sort_order' => 3,
            ],
            [
                'question' => 'What is your return/refund policy?',
                'answer' => 'If you receive damaged or incorrect items, please file a complaint within 24 hours through the app. We will arrange a replacement or refund to your wallet.',
                'sort_order' => 4,
            ],
            [
                'question' => 'How does the wallet work?',
                'answer' => 'Your wallet balance can be used during checkout. Refunds are credited to your wallet. You can choose to pay with wallet balance at the time of placing an order.',
                'sort_order' => 5,
            ],
            [
                'question' => 'Is there a minimum order amount?',
                'answer' => 'There is no minimum order amount, but free delivery is available on orders above Rs 2,000.',
                'sort_order' => 6,
            ],
        ];

        foreach ($faqs as $faq) {
            Faq::firstOrCreate(['question' => $faq['question']], array_merge($faq, ['is_active' => true]));
        }
    }

    private function seedSearchHistory(array $customers): void
    {
        $searches = [
            ['query' => 'tomatoes', 'results_count' => 3],
            ['query' => 'milk', 'results_count' => 2],
            ['query' => 'mango', 'results_count' => 1],
            ['query' => 'orange juice', 'results_count' => 2],
            ['query' => 'onion', 'results_count' => 1],
            ['query' => 'cheese', 'results_count' => 1],
            ['query' => 'banana', 'results_count' => 1],
            ['query' => 'fresh vegetables', 'results_count' => 4],
            ['query' => 'cola', 'results_count' => 1],
            ['query' => 'yogurt', 'results_count' => 1],
            ['query' => 'potato', 'results_count' => 1],
            ['query' => 'lemon', 'results_count' => 1],
        ];

        foreach ($searches as $i => $search) {
            $customer = $customers[$i % count($customers)];
            SearchHistory::create([
                'user_id' => $customer->id,
                'query' => $search['query'],
                'results_count' => $search['results_count'],
                'created_at' => now()->subHours(rand(1, 200)),
            ]);
        }
    }

    private function seedAppSettings(): void
    {
        $settings = [
            'app_name' => 'Cuba Groceries',
            'contact_email' => 'support@cubagroceries.pk',
            'contact_phone' => '03001234567',
            'whatsapp_number' => '03001234567',
            'min_order_amount' => '0',
            'currency_symbol' => 'Rs',
            'delivery_time_text' => '30-60 minutes',
            'about_us' => '<p>Cuba Groceries is your trusted online grocery store in Lahore, delivering fresh produce and daily essentials to your doorstep.</p>',
            'terms_and_conditions' => '<p>By using Cuba Groceries, you agree to our terms of service. All orders are subject to availability.</p>',
            'privacy_policy' => '<p>We respect your privacy. Your personal data is used only for order processing and delivery.</p>',
            'cancellation_pin' => '1234',
        ];

        foreach ($settings as $key => $value) {
            AppSetting::firstOrCreate(['key' => $key], ['value' => $value]);
        }
    }
}
