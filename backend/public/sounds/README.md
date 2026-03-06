# Sound Files

Place notification sound files here:

- `admin_alert.wav` — Plays in the Filament admin panel when new orders/complaints/reviews arrive.

The admin poller has a Web Audio API fallback that generates a chime tone if this file is missing, but placing the actual WAV provides a richer sound.
