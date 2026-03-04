<?php

namespace Tests\Feature\Admin;

use App\Models\PortalUser;
use Tests\TestCase;

class AdminAuthTest extends TestCase
{
    public function test_admin_login_page_loads(): void
    {
        $response = $this->get('/admin/login');

        $response->assertOk();
    }

    public function test_admin_dashboard_redirects_when_unauthenticated(): void
    {
        $response = $this->get('/admin');

        $response->assertRedirect('/admin/login');
    }

    public function test_admin_can_access_dashboard(): void
    {
        $admin = PortalUser::where('role', 1)->first();
        $this->assertNotNull($admin, 'Need a super admin user');

        $response = $this->actingAs($admin, 'portal')
            ->get('/admin');

        $response->assertOk();
    }

    public function test_staff_can_access_dashboard(): void
    {
        $staff = PortalUser::where('role', 3)->first();

        if (!$staff) {
            $this->markTestSkipped('No staff user');
        }

        $response = $this->actingAs($staff, 'portal')
            ->get('/admin');

        $response->assertOk();
    }
}
