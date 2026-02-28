<x-filament-panels::page>

    {{-- Survey Info Bar --}}
    <div class="flex flex-wrap items-center gap-3 mb-6">
        @if($this->survey->is_active)
            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                Active
            </span>
        @else
            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-gray-500/10 text-gray-400">
                <span class="w-1.5 h-1.5 rounded-full bg-gray-400"></span>
                Inactive
            </span>
        @endif

        <span class="text-sm text-gray-500">{{ $this->survey->questions->count() }} questions</span>

        @if($this->survey->starts_at)
            <span class="text-sm text-gray-500">• Started {{ $this->survey->starts_at->format('M d, Y') }}</span>
        @endif

        @if($this->survey->ends_at)
            <span class="text-sm text-gray-500">• Ends {{ $this->survey->ends_at->format('M d, Y') }}</span>
        @endif

        @if($this->survey->description)
            <span class="text-sm text-gray-500">• {{ $this->survey->description }}</span>
        @endif
    </div>

    {{-- Stats Cards --}}
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
        {{-- Total Responses --}}
        <div class="rounded-xl border border-white/5 bg-white/[0.02] p-5">
            <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 items-center justify-center rounded-lg" style="background: rgba(234,88,12,0.1);">
                    <x-heroicon-o-users class="h-5 w-5" style="color: rgb(234,88,12);" />
                </div>
                <div>
                    <p class="text-2xl font-bold text-white">{{ $this->stats['total'] }}</p>
                    <p class="text-xs text-gray-500 font-medium">Total Responses</p>
                </div>
            </div>
        </div>

        {{-- This Week --}}
        <div class="rounded-xl border border-white/5 bg-white/[0.02] p-5">
            <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-500/10">
                    <x-heroicon-o-calendar-days class="h-5 w-5 text-blue-400" />
                </div>
                <div>
                    <p class="text-2xl font-bold text-white">{{ $this->stats['this_week'] }}</p>
                    <p class="text-xs text-gray-500 font-medium">This Week</p>
                </div>
            </div>
        </div>

        {{-- Today --}}
        <div class="rounded-xl border border-white/5 bg-white/[0.02] p-5">
            <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 items-center justify-center rounded-lg bg-emerald-500/10">
                    <x-heroicon-o-clock class="h-5 w-5 text-emerald-400" />
                </div>
                <div>
                    <p class="text-2xl font-bold text-white">{{ $this->stats['today'] }}</p>
                    <p class="text-xs text-gray-500 font-medium">Today</p>
                </div>
            </div>
        </div>
    </div>

    {{-- Question Breakdowns --}}
    @if(count($this->questionBreakdowns) > 0)
        <div class="mb-8">
            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-4">Answer Breakdown</h3>
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">
                @foreach($this->questionBreakdowns as $breakdown)
                    <div class="rounded-xl border border-white/5 bg-white/[0.02] p-5">
                        <p class="text-sm font-semibold text-white mb-1">{{ $breakdown['question'] }}</p>
                        <p class="text-xs text-gray-500 mb-4">
                            {{ $breakdown['type'] === 'single_choice' ? 'Single choice' : 'Multiple choice' }}
                            • {{ $breakdown['total_answers'] }} {{ Str::plural('response', $breakdown['total_answers']) }}
                        </p>

                        <div class="space-y-3">
                            @foreach($breakdown['options'] as $option => $count)
                                @php
                                    $pct = $breakdown['total_answers'] > 0
                                        ? round(($count / $breakdown['total_answers']) * 100)
                                        : 0;
                                @endphp
                                <div>
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-sm text-gray-300">{{ $option }}</span>
                                        <span class="text-xs font-semibold text-gray-400">{{ $count }} ({{ $pct }}%)</span>
                                    </div>
                                    <div class="h-2 rounded-full bg-white/5 overflow-hidden">
                                        <div
                                            class="h-full rounded-full transition-all duration-500"
                                            style="width: {{ $pct }}%; background: rgb(234,88,12);"
                                        ></div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    @endif

    {{-- Free Text Answers --}}
    @php
        $textQuestions = $this->survey->questions->where('type', 'text');
        $allResponses = \App\Models\SurveyResponse::where('survey_id', $this->survey->id)->with('user')->latest()->get();
    @endphp

    @if($textQuestions->isNotEmpty())
        <div class="mb-8">
            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-4">Written Feedback</h3>
            @foreach($textQuestions as $tq)
                <div class="rounded-xl border border-white/5 bg-white/[0.02] p-5 mb-4">
                    <p class="text-sm font-semibold text-white mb-3">{{ $tq->question }}</p>
                    <div class="space-y-3">
                        @php $hasAnswers = false; @endphp
                        @foreach($allResponses as $resp)
                            @php
                                $textAnswer = $resp->answers[(string)$tq->id] ?? null;
                            @endphp
                            @if($textAnswer && is_string($textAnswer) && trim($textAnswer) !== '')
                                @php $hasAnswers = true; @endphp
                                <div class="flex gap-3 items-start pl-3 border-l-2 border-orange-500/30">
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm text-gray-300 leading-relaxed">{{ $textAnswer }}</p>
                                        <p class="text-xs text-gray-500 mt-1">
                                            {{ trim(($resp->user->firstname ?? '') . ' ' . ($resp->user->lastname ?? '')) }}
                                            • {{ $resp->created_at->diffForHumans() }}
                                        </p>
                                    </div>
                                </div>
                            @endif
                        @endforeach
                        @if(!$hasAnswers)
                            <p class="text-sm text-gray-500 italic">No written feedback yet.</p>
                        @endif
                    </div>
                </div>
            @endforeach
        </div>
    @endif

    {{-- Raw Responses Table --}}
    <div>
        <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-4">All Responses</h3>
        {{ $this->table }}
    </div>

</x-filament-panels::page>
