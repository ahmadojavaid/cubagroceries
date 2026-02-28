<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\StoreSchedule;

class StoreScheduleController extends Controller
{
    public function index()
    {
        $schedules = StoreSchedule::orderByRaw("CASE day
            WHEN 'monday' THEN 1
            WHEN 'tuesday' THEN 2
            WHEN 'wednesday' THEN 3
            WHEN 'thursday' THEN 4
            WHEN 'friday' THEN 5
            WHEN 'saturday' THEN 6
            WHEN 'sunday' THEN 7
            END")
            ->get(['id', 'day', 'open_time', 'close_time', 'is_closed']);

        return response()->json([
            'success' => true,
            'data' => $schedules,
        ]);
    }
}
