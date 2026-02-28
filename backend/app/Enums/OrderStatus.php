<?php

namespace App\Enums;

enum OrderStatus: string
{
    case Pending = 'pending';
    case Confirmed = 'confirmed';
    case Dispatched = 'dispatched';
    case Delivered = 'delivered';
    case Cancelled = 'cancelled';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::Confirmed => 'Confirmed',
            self::Dispatched => 'Dispatched',
            self::Delivered => 'Delivered',
            self::Cancelled => 'Cancelled',
        };
    }

    public function color(): string
    {
        return match ($this) {
            self::Pending => 'warning',
            self::Confirmed => 'info',
            self::Dispatched => 'primary',
            self::Delivered => 'success',
            self::Cancelled => 'danger',
        };
    }

    /**
     * Get the valid statuses this status can transition to.
     *
     * @return array<OrderStatus>
     */
    public function allowedTransitions(): array
    {
        return match ($this) {
            self::Pending => [self::Confirmed, self::Cancelled],
            self::Confirmed => [self::Dispatched, self::Cancelled],
            self::Dispatched => [self::Delivered, self::Cancelled],
            self::Delivered => [],
            self::Cancelled => [],
        };
    }

    /**
     * Check if transitioning to the given status is allowed.
     */
    public function canTransitionTo(OrderStatus $status): bool
    {
        return in_array($status, $this->allowedTransitions());
    }

    /**
     * Get allowed transitions as an associative array for Filament selects.
     *
     * @return array<string, string>
     */
    public function allowedTransitionOptions(): array
    {
        return collect($this->allowedTransitions())
            ->mapWithKeys(fn (OrderStatus $s) => [$s->value => $s->label()])
            ->all();
    }

    /**
     * Whether this status is a terminal (final) state.
     */
    public function isFinal(): bool
    {
        return empty($this->allowedTransitions());
    }

    /**
     * Get all statuses as options for Filament selects.
     *
     * @return array<string, string>
     */
    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (OrderStatus $s) => [$s->value => $s->label()])
            ->all();
    }
}
