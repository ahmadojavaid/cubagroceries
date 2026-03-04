<?php

namespace App\Notifications;

use App\Models\Order;
use App\Services\FcmService;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class RiderJobAssigned extends Notification
{
    use Queueable;

    public function __construct(
        protected Order $order,
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $customerName = $this->order->user->full_name ?? 'Customer';
        $address = $this->order->address->address ?? '';

        $data = [
            'order_id' => $this->order->id,
            'order_number' => $this->order->order_id,
            'title' => 'New Delivery Job!',
            'message' => "Order #{$this->order->order_id} from {$customerName} — {$address}",
        ];

        // Send FCM push to rider with special channel for alert sound
        if ($notifiable->fcm_token) {
            FcmService::sendToDevice(
                $notifiable->fcm_token,
                $data['title'],
                $data['message'],
                [
                    'type' => 'rider_job_assigned',
                    'order_number' => $this->order->order_id,
                ],
                'rider_job_alert',
            );
        }

        return $data;
    }
}
