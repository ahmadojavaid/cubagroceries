<?php

namespace App\Notifications;

use App\Enums\OrderStatus;
use App\Models\Order;
use App\Services\FcmService;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Log;

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
            'title' => $this->getTitle(),
            'message' => $this->getMessage(),
        ];

        // Send FCM push notification after building the data
        $this->sendFcmPush($notifiable, $data);

        return $data;
    }

    protected function sendFcmPush(object $notifiable, array $data): void
    {
        if (empty($notifiable->fcm_token)) {
            Log::info("FCM: No token for user {$notifiable->id}, skipping push for order {$this->order->order_id}");
            return;
        }

        try {
            $sent = FcmService::sendToDevice(
                $notifiable->fcm_token,
                $data['title'],
                $data['message'],
                [
                    'type' => 'order_status_changed',
                    'order_number' => $this->order->order_id,
                    'new_status' => $this->newStatus->value,
                ],
                'order_notifications',
            );

            Log::info("FCM: Order {$this->order->order_id} push " . ($sent ? 'sent' : 'failed') . " to user {$notifiable->id}");
        } catch (\Throwable $e) {
            Log::warning("FCM: Exception sending order push to user {$notifiable->id}: " . $e->getMessage());
        }
    }

    protected function getTitle(): string
    {
        return match ($this->newStatus) {
            OrderStatus::Confirmed  => '✅ Order Confirmed',
            OrderStatus::Dispatched => '🚚 Order On The Way',
            OrderStatus::Delivered  => '📦 Order Delivered',
            OrderStatus::Cancelled  => '❌ Order Cancelled',
            default                 => "Order {$this->order->order_id} Updated",
        };
    }

    protected function getMessage(): string
    {
        return match ($this->newStatus) {
            OrderStatus::Confirmed  => "Your order #{$this->order->order_id} has been confirmed and is being prepared.",
            OrderStatus::Dispatched => "Your order #{$this->order->order_id} is on the way! The rider is heading to your location.",
            OrderStatus::Delivered  => "Your order #{$this->order->order_id} has been delivered. Enjoy!",
            OrderStatus::Cancelled  => "Your order #{$this->order->order_id} has been cancelled.",
            default                 => "Your order #{$this->order->order_id} status changed to {$this->newStatus->label()}.",
        };
    }
}
