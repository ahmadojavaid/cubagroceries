<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class ManualPush extends Notification
{
    use Queueable;

    public function __construct(
        protected string $title,
        protected string $message,
        protected ?string $imageUrl = null,
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return array_filter([
            'title' => $this->title,
            'message' => $this->message,
            'image_url' => $this->imageUrl,
            'type' => 'manual_push',
        ]);
    }
}
