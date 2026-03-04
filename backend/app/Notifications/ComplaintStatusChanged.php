<?php

namespace App\Notifications;

use App\Models\Complaint;
use App\Services\FcmService;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Log;

class ComplaintStatusChanged extends Notification
{
    use Queueable;

    public function __construct(
        protected Complaint $complaint,
        protected string $oldStatus,
        protected string $newStatus,
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $data = [
            'complaint_id' => $this->complaint->id,
            'subject' => $this->complaint->subject,
            'old_status' => $this->oldStatus,
            'new_status' => $this->newStatus,
            'title' => $this->getTitle(),
            'message' => $this->getMessage(),
        ];

        $this->sendFcmPush($notifiable, $data);

        return $data;
    }

    protected function getTitle(): string
    {
        return match ($this->newStatus) {
            'in_progress' => '🔍 Complaint Under Review',
            'resolved' => '✅ Complaint Resolved',
            'closed' => '📋 Complaint Closed',
            default => '📋 Complaint Updated',
        };
    }

    protected function getMessage(): string
    {
        $subject = str()->limit($this->complaint->subject, 40);

        return match ($this->newStatus) {
            'in_progress' => "Your complaint \"{$subject}\" is now being reviewed by our team.",
            'resolved' => "Your complaint \"{$subject}\" has been successfully resolved!",
            'closed' => "Your complaint \"{$subject}\" has been closed.",
            default => "Your complaint \"{$subject}\" status has been updated.",
        };
    }

    protected function sendFcmPush(object $notifiable, array $data): void
    {
        if (empty($notifiable->fcm_token)) {
            Log::info("FCM: No token for user {$notifiable->id}, skipping push for complaint #{$this->complaint->id}");
            return;
        }

        try {
            $sent = FcmService::sendToDevice(
                $notifiable->fcm_token,
                $data['title'],
                $data['message'],
                [
                    'type' => 'complaint_status_changed',
                    'complaint_id' => (string) $this->complaint->id,
                    'new_status' => $this->newStatus,
                ],
                'order_notifications',
            );

            Log::info("FCM: Complaint #{$this->complaint->id} push " . ($sent ? 'sent' : 'failed') . " to user {$notifiable->id}");
        } catch (\Throwable $e) {
            Log::warning("FCM: Exception sending complaint push to user {$notifiable->id}: " . $e->getMessage());
        }
    }
}
