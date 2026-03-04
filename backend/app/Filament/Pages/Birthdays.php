<?php

namespace App\Filament\Pages;

use App\Models\User;
use App\Services\FcmService;
use Filament\Forms;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Concerns\InteractsWithTable;
use Filament\Tables\Contracts\HasTable;
use Illuminate\Database\Eloquent\Builder;

class Birthdays extends Page implements HasTable
{
    use InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-cake';

    protected static ?string $navigationGroup = 'Users';

    protected static ?int $navigationSort = 4;

    protected static ?string $title = 'Birthdays';

    protected static ?string $navigationLabel = 'Birthdays';

    protected static string $view = 'filament.pages.birthdays';

    public string $activeTab = 'today';

    public function getTableQuery(): Builder
    {
        $query = User::query()
            ->whereNotNull('date_of_birth');

        if ($this->activeTab === 'today') {
            $query->whereMonth('date_of_birth', now()->month)
                ->whereDay('date_of_birth', now()->day);
        } elseif ($this->activeTab === 'this_week') {
            $today = now();
            // Get birthdays in the next 7 days (month-day comparison)
            $query->where(function (Builder $q) use ($today) {
                for ($i = 0; $i <= 7; $i++) {
                    $date = $today->copy()->addDays($i);
                    $q->orWhere(function (Builder $sub) use ($date) {
                        $sub->whereMonth('date_of_birth', $date->month)
                            ->whereDay('date_of_birth', $date->day);
                    });
                }
            });
        } else {
            // This month
            $query->whereMonth('date_of_birth', now()->month);
        }

        return $query;
    }

    public function table(Table $table): Table
    {
        return $table
            ->query($this->getTableQuery())
            ->columns([
                Tables\Columns\TextColumn::make('full_name')
                    ->label('Customer')
                    ->searchable(['firstname', 'lastname']),

                Tables\Columns\TextColumn::make('email'),

                Tables\Columns\TextColumn::make('identity')
                    ->label('Phone'),

                Tables\Columns\TextColumn::make('date_of_birth')
                    ->label('Birthday')
                    ->date('M d, Y'),

                Tables\Columns\TextColumn::make('age')
                    ->label('Turns')
                    ->state(fn (User $record): string => $record->date_of_birth
                        ? now()->year - $record->date_of_birth->year . ' years'
                        : '—'),

                Tables\Columns\TextColumn::make('days_until')
                    ->label('In')
                    ->state(function (User $record): string {
                        if (! $record->date_of_birth) return '—';
                        $bday = $record->date_of_birth->copy()->year(now()->year);
                        if ($bday->isPast() && ! $bday->isToday()) {
                            $bday->addYear();
                        }
                        $days = now()->startOfDay()->diffInDays($bday->startOfDay());
                        return $days === 0 ? '🎂 Today!' : "{$days} days";
                    })
                    ->badge()
                    ->color(fn (string $state): string =>
                        str_contains($state, 'Today') ? 'success' : 'gray'),
            ])
            ->defaultSort('date_of_birth')
            ->actions([
                Tables\Actions\Action::make('sendWish')
                    ->label('Send Birthday Wish')
                    ->icon('heroicon-o-gift')
                    ->color('success')
                    ->form([
                        Forms\Components\TextInput::make('title')
                            ->label('Notification Title')
                            ->default('🎂 Happy Birthday!')
                            ->required()
                            ->maxLength(100),
                        Forms\Components\Textarea::make('message')
                            ->label('Message')
                            ->default(fn (User $record) => "Happy Birthday {$record->firstname}! 🎉 Wishing you a wonderful day from Asif Groceries.")
                            ->required()
                            ->maxLength(500)
                            ->rows(3),
                    ])
                    ->action(function (User $record, array $data): void {
                        $sent = false;

                        if ($record->fcm_token) {
                            $sent = FcmService::sendToDevice(
                                $record->fcm_token,
                                $data['title'],
                                $data['message'],
                                ['type' => 'birthday_wish'],
                            );
                        }

                        // Also store as a database notification
                        $record->notify(new \App\Notifications\ManualPush(
                            $data['title'],
                            $data['message'],
                        ));

                        Notification::make()
                            ->title($sent ? 'Push Sent!' : 'Notification Saved')
                            ->body($sent
                                ? "Birthday wish sent to {$record->full_name}."
                                : "Push delivery failed (no FCM token or device offline), but saved in notifications.")
                            ->color($sent ? 'success' : 'warning')
                            ->send();
                    })
                    ->modalHeading(fn (User $record) => "Birthday Wish — {$record->full_name}"),
            ])
            ->emptyStateHeading('No birthdays found')
            ->emptyStateDescription('No customers have birthdays in this period.')
            ->emptyStateIcon('heroicon-o-cake')
            ->paginated(false);
    }

    public function setTab(string $tab): void
    {
        $this->activeTab = $tab;
        $this->resetTable();
    }

    public static function getNavigationBadge(): ?string
    {
        $count = User::whereNotNull('date_of_birth')
            ->whereMonth('date_of_birth', now()->month)
            ->whereDay('date_of_birth', now()->day)
            ->count();

        return $count > 0 ? (string) $count : null;
    }

    public static function getNavigationBadgeColor(): ?string
    {
        return 'success';
    }
}
