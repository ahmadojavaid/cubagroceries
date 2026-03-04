<?php

namespace Tests\Feature\Admin;

use App\Models\PortalUser;
use Tests\TestCase;

class AdminResourceAccessTest extends TestCase
{
    private function admin(): PortalUser
    {
        return PortalUser::where('role', 1)->first();
    }

    private function staff(): ?PortalUser
    {
        return PortalUser::where('role', 3)->first();
    }

    // --- Admin can access all resources ---

    public function test_admin_can_list_orders(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/orders');

        $response->assertOk();
    }

    public function test_admin_can_list_products(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/products');

        $response->assertOk();
    }

    public function test_admin_can_list_categories(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/categories');

        $response->assertOk();
    }

    public function test_admin_can_list_customers(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/customers');

        $response->assertOk();
    }

    public function test_admin_can_list_delivery_boys(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/delivery-boys');

        $response->assertOk();
    }

    public function test_admin_can_list_coupons(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/coupons');

        $response->assertOk();
    }

    public function test_admin_can_list_shipping_charges(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/shipping-charges');

        $response->assertOk();
    }

    public function test_admin_can_list_complaints(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/complaints');

        $response->assertOk();
    }

    public function test_admin_can_list_units(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/units');

        $response->assertOk();
    }

    public function test_admin_can_access_other_settings(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/other-settings');

        $response->assertOk();
    }

    public function test_admin_can_access_store_holiday_mode(): void
    {
        $response = $this->actingAs($this->admin(), 'portal')
            ->get('/admin/store-holiday-mode');

        $response->assertOk();
    }

    // --- Staff access restrictions ---

    public function test_staff_can_access_orders(): void
    {
        $staff = $this->staff();
        if (!$staff) {
            $this->markTestSkipped('No staff user');
        }

        $response = $this->actingAs($staff, 'portal')
            ->get('/admin/orders');

        $response->assertOk();
    }

    public function test_staff_cannot_access_settings(): void
    {
        $staff = $this->staff();
        if (!$staff) {
            $this->markTestSkipped('No staff user');
        }

        $response = $this->actingAs($staff, 'portal')
            ->get('/admin/other-settings');

        $response->assertStatus(403);
    }
}
