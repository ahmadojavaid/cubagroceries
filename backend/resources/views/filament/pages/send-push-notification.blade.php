<x-filament-panels::page>
    {{-- FCM Configuration Status Banner --}}
    @php
        $fcmIssues = \App\Services\FcmService::diagnose();
    @endphp

    @if(count($fcmIssues) > 0)
        <div class="rounded-xl border border-red-200 bg-red-50 p-4 dark:border-red-800 dark:bg-red-950">
            <div class="flex items-start gap-3">
                <x-heroicon-o-exclamation-triangle class="w-6 h-6 text-red-500 mt-0.5 flex-shrink-0" />
                <div>
                    <h3 class="font-semibold text-red-800 dark:text-red-200">Push Notifications Unavailable</h3>
                    <p class="text-sm text-red-600 dark:text-red-400 mt-1">
                        FCM is not properly configured. Notifications will be saved in-app but <strong>will not</strong> be delivered as push notifications to devices.
                    </p>
                    <ul class="mt-2 text-sm text-red-600 dark:text-red-400 list-disc list-inside space-y-1">
                        @foreach($fcmIssues as $issue)
                            <li>{{ $issue }}</li>
                        @endforeach
                    </ul>
                </div>
            </div>
        </div>
    @else
        <div class="rounded-xl border border-green-200 bg-green-50 p-4 dark:border-green-800 dark:bg-green-950">
            <div class="flex items-center gap-3">
                <x-heroicon-o-check-circle class="w-6 h-6 text-green-500 flex-shrink-0" />
                <div>
                    <h3 class="font-semibold text-green-800 dark:text-green-200">FCM Connected</h3>
                    <p class="text-sm text-green-600 dark:text-green-400">
                        Firebase Cloud Messaging is configured and ready. Push notifications will be delivered to devices with registered tokens.
                    </p>
                </div>
            </div>
        </div>
    @endif

    {{-- Push Notification Form --}}
    <form wire:submit="send" class="mt-4">
        {{ $this->form }}

        <div class="mt-6 flex items-center gap-3">
            <x-filament::button type="submit" size="lg" wire:loading.attr="disabled">
                <span wire:loading.remove wire:target="send">
                    Send Notification
                </span>
                <span wire:loading wire:target="send">
                    Sending...
                </span>
            </x-filament::button>

            <span wire:loading wire:target="send" class="text-sm text-gray-500">
                Please wait while notifications are being sent...
            </span>
        </div>
    </form>
</x-filament-panels::page>
