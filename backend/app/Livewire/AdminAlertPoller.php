<?php

namespace App\Livewire;

use App\Models\Complaint;
use App\Models\Order;
use App\Models\OrderReview;
use App\Models\Review;
use App\Models\SurveyResponse;
use Livewire\Component;

class AdminAlertPoller extends Component
{
    /**
     * Track the last check timestamp per browser session.
     * Polls every 15s via Alpine JS and calls checkForNew().
     */

    public string $lastCheck = '';

    public function mount(): void
    {
        // Initialize to "now" so we don't alert on existing records
        $this->lastCheck = now()->toIso8601String();
    }

    public function checkForNew(): array
    {
        $since = $this->lastCheck;

        $newOrders = Order::where('created_at', '>', $since)->count();
        $newReviews = Review::where('created_at', '>', $since)->count();
        $newOrderReviews = OrderReview::where('created_at', '>', $since)->count();
        $newComplaints = Complaint::where('created_at', '>', $since)->count();
        $newSurveyResponses = SurveyResponse::where('created_at', '>', $since)->count();

        // Update the checkpoint
        $this->lastCheck = now()->toIso8601String();

        $totalNew = $newOrders + $newReviews + $newOrderReviews + $newComplaints + $newSurveyResponses;

        $alerts = [];
        if ($newOrders > 0) $alerts[] = "{$newOrders} new order" . ($newOrders > 1 ? 's' : '');
        if ($newReviews > 0) $alerts[] = "{$newReviews} new review" . ($newReviews > 1 ? 's' : '');
        if ($newOrderReviews > 0) $alerts[] = "{$newOrderReviews} order review" . ($newOrderReviews > 1 ? 's' : '');
        if ($newComplaints > 0) $alerts[] = "{$newComplaints} new complaint" . ($newComplaints > 1 ? 's' : '');
        if ($newSurveyResponses > 0) $alerts[] = "{$newSurveyResponses} survey response" . ($newSurveyResponses > 1 ? 's' : '');

        return [
            'hasNew' => $totalNew > 0,
            'message' => implode(', ', $alerts),
        ];
    }

    public function render()
    {
        return view('livewire.admin-alert-poller');
    }
}
