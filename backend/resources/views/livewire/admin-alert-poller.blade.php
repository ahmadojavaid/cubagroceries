<div
    x-data="adminAlertPoller()"
    x-init="startPolling()"
    class="hidden"
>
    {{-- Toast container --}}
    <div
        x-show="showToast"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="opacity-0 translate-y-2"
        x-transition:enter-end="opacity-100 translate-y-0"
        x-transition:leave="transition ease-in duration-200"
        x-transition:leave-start="opacity-100 translate-y-0"
        x-transition:leave-end="opacity-0 translate-y-2"
        style="position:fixed; bottom:1rem; right:1rem; z-index:9999; max-width:360px;"
        class="bg-white dark:bg-gray-800 rounded-xl shadow-2xl border border-gray-200 dark:border-gray-700 p-4"
    >
        <div class="flex items-start gap-3">
            <div class="shrink-0 w-10 h-10 rounded-full bg-primary-50 dark:bg-primary-500/10 flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-primary-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
                </svg>
            </div>
            <div class="flex-1 min-w-0">
                <p class="text-sm font-semibold text-gray-900 dark:text-white">New Activity</p>
                <p class="text-sm text-gray-500 dark:text-gray-400 mt-0.5" x-text="toastMessage"></p>
            </div>
            <button @click="dismissToast()" class="shrink-0 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
    </div>

    {{-- Mute toggle (in the bottom-left) --}}
    <div style="position:fixed; bottom:1rem; left:1rem; z-index:9998;">
        <button
            @click="toggleMute()"
            class="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-medium transition-colors"
            :class="muted
                ? 'bg-gray-100 dark:bg-gray-800 text-gray-400'
                : 'bg-primary-50 dark:bg-primary-500/10 text-primary-600 dark:text-primary-400'"
            :title="muted ? 'Unmute alerts' : 'Mute alerts'"
        >
            <svg x-show="!muted" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.114 5.636a9 9 0 010 12.728M16.463 8.288a5.25 5.25 0 010 7.424M6.75 8.25l4.72-4.72a.75.75 0 011.28.53v15.88a.75.75 0 01-1.28.53l-4.72-4.72H4.51c-.88 0-1.704-.507-1.938-1.354A9.01 9.01 0 012.25 12c0-.83.112-1.633.322-2.396C2.806 8.756 3.63 8.25 4.51 8.25H6.75z" />
            </svg>
            <svg x-show="muted" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 9.75L19.5 12m0 0l2.25 2.25M19.5 12l2.25-2.25M19.5 12l-2.25 2.25m-10.5-6l4.72-4.72a.75.75 0 011.28.531V19.94a.75.75 0 01-1.28.53l-4.72-4.72H4.51c-.88 0-1.704-.508-1.938-1.354A9.01 9.01 0 012.25 12c0-.83.112-1.633.322-2.396C2.806 8.756 3.63 8.25 4.51 8.25H6.75z" />
            </svg>
            <span x-text="muted ? 'Muted' : 'Alerts on'"></span>
        </button>
    </div>
</div>

@script
<script>
    Alpine.data('adminAlertPoller', () => ({
        showToast: false,
        toastMessage: '',
        muted: localStorage.getItem('admin_alert_muted') === 'true',
        audio: null,
        audioReady: false,
        audioUnlocked: false,
        pollInterval: null,

        startPolling() {
            // Pre-load MP3 file
            this.audio = new Audio('/sounds/admin_alert.mp3');
            this.audio.volume = 0.8;
            this.audio.loop = true; // Loop until dismissed
            this.audio.addEventListener('canplaythrough', () => { this.audioReady = true; });
            this.audio.addEventListener('error', (e) => {
                console.warn('Alert sound failed to load:', e);
                this.audioReady = false;
            });

            // Unlock audio on any user interaction (browser autoplay policy)
            const unlock = () => {
                if (this.audioUnlocked) return;
                // Play then immediately pause to unlock the audio context
                if (this.audio) {
                    const p = this.audio.play();
                    if (p) p.then(() => {
                        this.audio.pause();
                        this.audio.currentTime = 0;
                    }).catch(() => {});
                }
                this.audioUnlocked = true;
                document.removeEventListener('click', unlock);
                document.removeEventListener('keydown', unlock);
            };
            document.addEventListener('click', unlock, { once: false });
            document.addEventListener('keydown', unlock, { once: false });

            // Poll every 15 seconds
            this.pollInterval = setInterval(() => this.poll(), 15000);
        },

        async poll() {
            try {
                const result = await $wire.checkForNew();
                if (result.hasNew) {
                    this.toastMessage = result.message;
                    this.showToast = true;

                    if (!this.muted) {
                        this.playSound();
                    }
                }
            } catch (e) {
                // Silently ignore poll failures
            }
        },

        playSound() {
            if (this.audioReady && this.audio) {
                try {
                    this.audio.currentTime = 0;
                    this.audio.loop = true;
                    this.audio.play().catch((e) => console.warn('Sound play blocked:', e));
                } catch (e) {
                    console.warn('Sound error:', e);
                }
            }
        },

        stopSound() {
            if (this.audio) {
                this.audio.pause();
                this.audio.currentTime = 0;
            }
        },

        dismissToast() {
            this.showToast = false;
            this.stopSound();
        },

        toggleMute() {
            this.muted = !this.muted;
            localStorage.setItem('admin_alert_muted', this.muted);
            if (this.muted) this.stopSound();
        },

        destroy() {
            if (this.pollInterval) clearInterval(this.pollInterval);
            this.stopSound();
        }
    }));
</script>
@endscript
