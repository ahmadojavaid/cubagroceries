<?php

namespace Database\Seeders;

use App\Enums\OrderStatus;
use App\Models\Address;
use App\Models\Complaint;
use App\Models\DeliveryBoy;
use App\Models\Order;
use App\Models\OrderAddress;
use App\Models\Orderproduct;
use App\Models\Price;
use App\Models\Product;
use App\Models\ShippingCharge;
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

        $this->seedComplaints($customers);
        $this->command->info('  ✓ Complaints');

        $this->seedNotifications($customers);
        $this->command->info('  ✓ Notifications');

        $this->command->info('Sample data seeding complete!');
    }

    private function seedShippingCharges(): void
    {
        $charges = [
            ['title' => 'Standard Delivery', 'amount' => 100.00],
            ['title' => 'Express Delivery', 'amount' => 200.00],
            ['title' => 'Free Delivery (Rs 2000+)', 'amount' => 0.00],
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
            ],
            [
                'identity' => '03004445566',
                'email' => 'sara@example.com',
                'firstname' => 'Sara',
                'lastname' => 'Ahmed',
                'password' => 'password',
                'date_of_birth' => now()->format('Y-m-d'), // birthday today!
                'wallet_amount' => 1200.00,
            ],
            [
                'identity' => '03007778899',
                'email' => 'usman@example.com',
                'firstname' => 'Usman',
                'lastname' => 'Malik',
                'password' => 'password',
                'date_of_birth' => '1990-03-22',
                'wallet_amount' => 0.00,
            ],
            [
                'identity' => '03212223344',
                'email' => 'fatima@example.com',
                'firstname' => 'Fatima',
                'lastname' => 'Noor',
                'password' => 'password',
                'date_of_birth' => '1998-11-08',
                'wallet_amount' => 350.00,
            ],
            [
                'identity' => '03335556677',
                'email' => 'hassan@example.com',
                'firstname' => 'Hassan',
                'lastname' => 'Raza',
                'password' => 'password',
                'date_of_birth' => '1992-01-30',
                'wallet_amount' => 2000.00,
            ],
        ];

        $result = [];
        foreach ($customers as $data) {
            $result[] = User::firstOrCreate(
                ['email' => $data['email']],
                $data
            );
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
            // Ali Khan — 3 orders (various statuses)
            ['customer' => 0, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 3, 'days_ago' => 15],
            ['customer' => 0, 'status' => OrderStatus::Dispatched, 'rider' => 1, 'items' => 2, 'days_ago' => 2],
            ['customer' => 0, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 4, 'days_ago' => 0],

            // Sara Ahmed — 2 orders
            ['customer' => 1, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 2, 'days_ago' => 10],
            ['customer' => 1, 'status' => OrderStatus::Confirmed, 'rider' => null, 'items' => 3, 'days_ago' => 1],

            // Usman Malik — 2 orders
            ['customer' => 2, 'status' => OrderStatus::Delivered, 'rider' => 2, 'items' => 5, 'days_ago' => 20],
            ['customer' => 2, 'status' => OrderStatus::Cancelled, 'rider' => null, 'items' => 1, 'days_ago' => 5],

            // Fatima Noor — 2 orders
            ['customer' => 3, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 2, 'days_ago' => 0],
            ['customer' => 3, 'status' => OrderStatus::Delivered, 'rider' => 1, 'items' => 3, 'days_ago' => 8],

            // Hassan Raza — 3 orders
            ['customer' => 4, 'status' => OrderStatus::Delivered, 'rider' => 0, 'items' => 4, 'days_ago' => 12],
            ['customer' => 4, 'status' => OrderStatus::Dispatched, 'rider' => 2, 'items' => 2, 'days_ago' => 1],
            ['customer' => 4, 'status' => OrderStatus::Pending, 'rider' => null, 'items' => 3, 'days_ago' => 0],
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

            $orderNumber = 'CUBA' . str_pad(rand(10000000, 99999999), 8, '0', STR_PAD_LEFT);
            $createdAt = now()->subDays($config['days_ago'])->subHours(rand(0, 12));

            // Check if this customer already has enough orders
            $existingCount = Order::where('user_id', $customer->id)->count();
            if ($existingCount >= 5) continue;

            $order = Order::create([
                'order_id' => $orderNumber,
                'user_id' => $customer->id,
                'status' => $config['status'],
                'total_amount' => $totalAmount,
                'delivery_boy_id' => $config['rider'] !== null ? $deliveryBoys[$config['rider']]->id : null,
                'created_at' => $createdAt,
                'updated_at' => $createdAt,
            ]);

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

    private function seedNotifications(array $customers): void
    {
        // Create sample notifications for delivered/dispatched orders
        $orders = Order::whereIn('status', [
            OrderStatus::Delivered,
            OrderStatus::Dispatched,
            OrderStatus::Confirmed,
        ])->with('user')->get();

        foreach ($orders as $order) {
            // Simulate a status change notification
            $previousStatus = match ($order->status) {
                OrderStatus::Confirmed => OrderStatus::Pending,
                OrderStatus::Dispatched => OrderStatus::Confirmed,
                OrderStatus::Delivered => OrderStatus::Dispatched,
                default => OrderStatus::Pending,
            };

            // Only create if user doesn't already have too many notifications
            $existingCount = $order->user->notifications()->count();
            if ($existingCount >= 6) continue;

            $order->user->notify(new OrderStatusChanged($order, $previousStatus, $order->status));
        }

        // Mark some as read for realism
        foreach ($customers as $customer) {
            $customer->notifications()->limit(2)->update(['read_at' => now()]);
        }
    }
}
