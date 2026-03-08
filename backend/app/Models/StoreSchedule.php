<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StoreSchedule extends Model
{
    protected $fillable = [
        'day',
        'open_time',
        'close_time',
        'is_closed',
    ];

    protected function casts(): array
    {
        return [
            'is_closed' => 'boolean',
            'open_time' => 'datetime:H:i',
            'close_time' => 'datetime:H:i',
        ];
    }

    public const DAYS = [
        'monday' => 'Monday',
        'tuesday' => 'Tuesday',
        'wednesday' => 'Wednesday',
        'thursday' => 'Thursday',
        'friday' => 'Friday',
        'saturday' => 'Saturday',
        'sunday' => 'Sunday',
    ];

    /**
     * Check if the store is currently outside daily operating hours.
     * Returns true if store should be offline based on schedule.
     * Returns false if within hours OR no schedule is configured.
     */
    public static function isOutsideOperatingHours(): bool
    {
        $today = strtolower(now()->format('l')); // e.g. 'monday'
        $schedule = static::where('day', $today)->first();

        // No schedule for today = store is open (no restriction)
        if (! $schedule) return false;

        // Day marked as closed
        if ($schedule->is_closed) return true;

        // Check if current time is within open/close window
        $now = now()->format('H:i:s');
        $open = $schedule->getRawOriginal('open_time');
        $close = $schedule->getRawOriginal('close_time');

        if (! $open || ! $close) return false;

        return $now < $open || $now > $close;
    }

    /**
     * Get today's schedule info for the API.
     */
    public static function getTodaySchedule(): ?array
    {
        $today = strtolower(now()->format('l'));
        $schedule = static::where('day', $today)->first();

        if (! $schedule) return null;

        return [
            'day' => $schedule->day,
            'is_closed' => $schedule->is_closed,
            'open_time' => $schedule->is_closed ? null : $schedule->getRawOriginal('open_time'),
            'close_time' => $schedule->is_closed ? null : $schedule->getRawOriginal('close_time'),
        ];
    }
}
