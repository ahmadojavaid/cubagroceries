<?php

namespace Tests\Feature\Admin;

use App\Models\Order;
use App\Models\PortalUser;
use Tests\TestCase;

class OrderViewTest extends TestCase
{
    private function admin(): PortalUser
    {
        return PortalUser::where('role', 1)->first();
    }

    public function test_order_view_page_loads(): void
    {
        $order = Order::first();
        $this->assertNotNull($order, 'Need at least one order');

        $response = $this->actingAs($this->admin(), 'portal')
            ->get("/admin/orders/{$order->id}");

        $response->assertOk();
    }

    public function test_order_view_contains_order_id(): void
    {
        $order = Order::first();

        $response = $this->actingAs($this->admin(), 'portal')
            ->get("/admin/orders/{$order->id}");

        $response->assertOk()
            ->assertSee($order->order_id);
    }

    public function test_order_view_shows_customer_info(): void
    {
        $order = Order::with('user')->first();

        $response = $this->actingAs($this->admin(), 'portal')
            ->get("/admin/orders/{$order->id}");

        $response->assertOk()
            ->assertSee($order->user->email);
    }

    public function test_order_invoice_page_loads(): void
    {
        $order = Order::first();

        $response = $this->actingAs($this->admin(), 'portal')
            ->get("/admin/orders/{$order->id}/invoice");

        $response->assertOk()
            ->assertSee('Invoice')
            ->assertSee($order->order_id);
    }

    public function test_order_invoice_requires_portal_auth(): void
    {
        $order = Order::first();

        $response = $this->get("/admin/orders/{$order->id}/invoice");

        $response->assertStatus(403);
    }

    public function test_order_invoice_contains_items(): void
    {
        $order = Order::with('products.product')->first();

        $response = $this->actingAs($this->admin(), 'portal')
            ->get("/admin/orders/{$order->id}/invoice");

        $response->assertOk();

        // Should contain at least one product name
        if ($order->products->isNotEmpty()) {
            $response->assertSee($order->products->first()->product->name);
        }
    }
}
