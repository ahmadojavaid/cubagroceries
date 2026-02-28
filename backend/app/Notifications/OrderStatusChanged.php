<?php

namespace App\Notifications;

use App\Enums\OrderStatus;
use App\Models\Order;
use App\Services\FcmService;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class OrderStatusChanged extends Notification
{
    use Queueable;

    public function __construct(
        protected Order $order,
        protected OrderStatus $oldStatus,
        protected OrderStatus $newStatus,
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $data = [
            'order_id' => $this->order->id,
            'order_number' => $this->order->order_id,
            'old_status' => $this->oldStatus->value,
            'new_status' => $this->newStatus->value,
            'title' => "Order {$this->order->order_id} Updated",
            'message' => "Your order {$this->order->order_id} status changed from {$this->oldStatus->label()} to {$this->newStatus->label()}.",
        ];

        // Send FCM push notification if user has a token
        if ($notifiable->fcm_token) {
            FcmService::sendToDevice(
                $notifiable->fcm_token,
                $data['title'],
                $data['message'],
                [
                    'type' => 'order_status_changed',
                    'order_number' => $this->order->order_id,
                ],
            );
        }

        return $data;
    }
}
