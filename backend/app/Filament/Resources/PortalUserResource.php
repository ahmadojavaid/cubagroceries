<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PortalUserResource\Pages;
use App\Models\PortalUser;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;

class PortalUserResource extends Resource
{
    protected static ?string $model = PortalUser::class;

    protected static ?string $navigationIcon = 'heroicon-o-shield-check';

    protected static ?string $navigationGroup = 'Users';

    protected static ?int $navigationSort = 2;

    protected static ?string $modelLabel = 'Staff Member';

    protected static ?string $pluralModelLabel = 'Staff Members';

    protected static ?string $slug = 'staff';

    /**
     * Only Super Admin (role 1) can access this resource.
     */
    public static function canAccess(): bool
    {
        $user = Auth::guard('portal')->user();
        return $user instanceof PortalUser && $user->isSuperAdmin();
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Account Details')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255),

                        Forms\Components\TextInput::make('email')
                            ->email()
                            ->required()
                            ->unique(ignoreRecord: true)
                            ->maxLength(255),

                        Forms\Components\TextInput::make('password')
                            ->password()
                            ->revealable()
                            ->required(fn (string $operation): bool => $operation === 'create')
                            ->dehydrated(fn (?string $state): bool => filled($state))
                            ->maxLength(255)
                            ->helperText(fn (string $operation) => $operation === 'edit'
                                ? 'Leave blank to keep current password'
                                : null),

                        Forms\Components\Select::make('role')
                            ->options([
                                PortalUser::ROLE_SUPER_ADMIN => 'Super Admin',
                                PortalUser::ROLE_ADMIN => 'Admin',
                                PortalUser::ROLE_STAFF => 'Staff',
                            ])
                            ->required()
                            ->default(PortalUser::ROLE_STAFF),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('email')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('role')
                    ->badge()
                    ->formatStateUsing(fn (int $state): string => match ($state) {
                        PortalUser::ROLE_SUPER_ADMIN => 'Super Admin',
                        PortalUser::ROLE_ADMIN => 'Admin',
                        PortalUser::ROLE_STAFF => 'Staff',
                        default => 'Unknown',
                    })
                    ->color(fn (int $state): string => match ($state) {
                        PortalUser::ROLE_SUPER_ADMIN => 'danger',
                        PortalUser::ROLE_ADMIN => 'warning',
                        PortalUser::ROLE_STAFF => 'info',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Created')
                    ->dateTime('M d, Y')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('role')
                    ->options([
                        PortalUser::ROLE_SUPER_ADMIN => 'Super Admin',
                        PortalUser::ROLE_ADMIN => 'Admin',
                        PortalUser::ROLE_STAFF => 'Staff',
                    ]),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make()
                    ->hidden(fn (PortalUser $record): bool => $record->id === Auth::guard('portal')->id()),
            ])
            ->bulkActions([])
            ->defaultSort('id', 'asc');
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPortalUsers::route('/'),
            'create' => Pages\CreatePortalUser::route('/create'),
            'edit' => Pages\EditPortalUser::route('/{record}/edit'),
        ];
    }
}
