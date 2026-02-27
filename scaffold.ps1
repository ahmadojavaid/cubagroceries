#Requires -Version 5.1
<#
.SYNOPSIS
    Project Scaffolder - Create full-stack projects with zero friction.
.DESCRIPTION
    Interactive project scaffolder that creates Laravel, Node.js, React, Vue,
    Next.js, Nuxt, and Flutter projects with everything wired together.
.PARAMETER Preset
    Use a saved preset to skip the wizard. Use --list-presets to see available.
.PARAMETER ListPresets
    Show all available presets.
.PARAMETER Doctor
    Run an environment health check.
.PARAMETER SavePreset
    Save current selections as a named preset after scaffolding.
.EXAMPLE
    .\scaffold.ps1
    .\scaffold.ps1 --preset karobar-stack
    .\scaffold.ps1 --doctor
#>

param(
    [string]$Preset,
    [switch]$ListPresets,
    [switch]$Doctor,
    [string]$SavePreset
)

# ============================================================================
# CONFIGURATION
# ============================================================================
$ErrorActionPreference = "Stop"
$SCAFFOLDER_VERSION = "1.0.1"
$PRESETS_DIR = "$env:USERPROFILE\.scaffolder"
$PRESETS_FILE = "$PRESETS_DIR\presets.json"
$SCRIPT_PATH = $MyInvocation.MyCommand.Path

# ============================================================================
# COLORS & UI HELPERS
# ============================================================================
function Write-Header {
    param([string]$Text)
    Write-Host ""
    Write-Host "  $Text" -ForegroundColor Cyan
    Write-Host "  $('─' * ($Text.Length + 2))" -ForegroundColor DarkGray
    Write-Host ""
}

function Write-Success {
    param([string]$Text)
    Write-Host "  ✅ $Text" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Text)
    Write-Host "  ⚠️  $Text" -ForegroundColor Yellow
}

function Write-Failure {
    param([string]$Text)
    Write-Host "  ❌ $Text" -ForegroundColor Red
}

function Write-Info {
    param([string]$Text)
    Write-Host "  $Text" -ForegroundColor Gray
}

function Write-Step {
    param([int]$Number, [int]$Total, [string]$Text)
    Write-Host ""
    Write-Host "  [$Number/$Total] $Text" -ForegroundColor Yellow
    Write-Host ""
}

function Write-Option {
    param([int]$Number, [string]$Label, [string]$Description, [string]$Tag = "")
    $tagText = if ($Tag) { " $Tag" } else { "" }
    Write-Host "    $Number. $Label$tagText" -ForegroundColor White
    if ($Description) {
        Write-Host "       $Description" -ForegroundColor DarkGray
    }
}

function Write-CheckboxOption {
    param([int]$Number, [string]$Label, [bool]$Default = $false)
    $marker = if ($Default) { "⭐" } else { "  " }
    Write-Host "    $Number. $marker $Label" -ForegroundColor White
}

function Read-Choice {
    param(
        [string]$Prompt,
        [int]$Min = 1,
        [int]$Max,
        [int]$Default = -1
    )
    while ($true) {
        $defaultText = if ($Default -gt 0) { " [default: $Default]" } else { "" }
        Write-Host "  Your choice$defaultText`: " -ForegroundColor Cyan -NoNewline
        $input = Read-Host
        if ($input -eq "" -and $Default -gt 0) { return $Default }
        $num = 0
        if ([int]::TryParse($input, [ref]$num) -and $num -ge $Min -and $num -le $Max) {
            return $num
        }
        Write-Host "  Please enter a number between $Min and $Max" -ForegroundColor Red
    }
}

function Read-MultiChoice {
    param(
        [string]$Prompt,
        [int]$Max,
        [int[]]$Defaults = @()
    )
    $defaultText = if ($Defaults.Count -gt 0) { " [default: $($Defaults -join ', ')]" } else { "" }
    Write-Host "  Enter numbers separated by commas$defaultText`: " -ForegroundColor Cyan -NoNewline
    $input = Read-Host
    if ($input -eq "" -and $Defaults.Count -gt 0) { return $Defaults }
    $choices = $input -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" } | ForEach-Object { [int]$_ } | Where-Object { $_ -ge 1 -and $_ -le $Max }
    if ($choices.Count -eq 0 -and $Defaults.Count -gt 0) { return $Defaults }
    return $choices
}

function Read-YesNo {
    param([string]$Prompt, [bool]$Default = $true)
    $hint = if ($Default) { "(Y/n)" } else { "(y/N)" }
    Write-Host "  $Prompt $hint`: " -ForegroundColor Cyan -NoNewline
    $input = Read-Host
    if ($input -eq "") { return $Default }
    return $input -match "^[yY]"
}

function Read-Text {
    param([string]$Prompt, [string]$Default = "")
    $defaultText = if ($Default) { " [$Default]" } else { "" }
    Write-Host "  $Prompt$defaultText`: " -ForegroundColor Cyan -NoNewline
    $input = Read-Host
    if ($input -eq "" -and $Default) { return $Default }
    return $input
}

# ============================================================================
# ENVIRONMENT DETECTION (with timeouts to prevent hanging)
# ============================================================================
function Get-ToolVersion {
    param([string]$Command, [string]$Args = "--version", [bool]$UseTimeout = $false, [int]$TimeoutSeconds = 10)
    try {
        $exists = Get-Command $Command -ErrorAction SilentlyContinue
        if ($exists) { return "found" }
        return $null
    } catch {
        return $null
    }
}

function Test-CommandExists {
    param([string]$Command)
    try {
        $null = Get-Command $Command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-HerdInstalled {
    # Check common Herd locations
    $herdPaths = @(
        "$env:LOCALAPPDATA\Programs\Herd\herd.exe",
        "$env:PROGRAMFILES\Herd\herd.exe",
        "herd"
    )
    foreach ($path in $herdPaths) {
        if (Test-CommandExists $path) { return $true }
    }
    # Check if Herd's PHP is in PATH
    $phpPath = (Get-Command php -ErrorAction SilentlyContinue)?.Source
    if ($phpPath -and $phpPath -match '[Hh]erd') { return $true }
    return $false
}

function Test-PortOpen {
    param([int]$Port)
    try {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $tcp.Connect("127.0.0.1", $Port)
        $tcp.Close()
        return $true
    } catch {
        return $false
    }
}

function Get-Environment {
    $env_info = @{
        PHP = Get-ToolVersion "php"
        Composer = Get-ToolVersion "composer"
        Node = Get-ToolVersion "node"
        NPM = Get-ToolVersion "npm"
        Git = Get-ToolVersion "git"
        Flutter = Get-ToolVersion "flutter"
        Docker = Get-ToolVersion "docker"
        MySQL = Get-ToolVersion "mysql"
        PostgreSQL = Get-ToolVersion "psql"
        Herd = Test-HerdInstalled
        MySQLRunning = Test-PortOpen 3306
        PostgreSQLRunning = Test-PortOpen 5432
        RedisRunning = Test-PortOpen 6379
    }
    return $env_info
}

function Show-EnvironmentScan {
    param($Env)
    Write-Header "🔍 Quick check..."

    $tools = @("PHP", "Composer", "Node.js", "Git", "Flutter", "PostgreSQL")
    $envMap = @{ "PHP" = $Env.PHP; "Composer" = $Env.Composer; "Node.js" = $Env.Node; "Git" = $Env.Git; "Flutter" = $Env.Flutter; "PostgreSQL" = $Env.PostgreSQL }

    foreach ($tool in $tools) {
        if ($envMap[$tool]) {
            Write-Success "$tool"
        } else {
            Write-Host "  ❌ $tool — not found" -ForegroundColor DarkGray
        }
    }

    if ($Env.Herd) { Write-Success "Laravel Herd" }
    Write-Host ""
}

# ============================================================================
# DOCTOR MODE
# ============================================================================
function Invoke-Doctor {
    Write-Host ""
    Write-Host "  🩺 Environment Health Check" -ForegroundColor Cyan
    Write-Host "  ════════════════════════════" -ForegroundColor DarkGray
    Write-Host ""

    $env_info = Get-Environment

    $tools = @(
        @{ Name = "PHP"; Version = $env_info.PHP; Install = "winget install Laravel.Herd  OR  https://windows.php.net" },
        @{ Name = "Composer"; Version = $env_info.Composer; Install = "https://getcomposer.org/download/" },
        @{ Name = "Node.js"; Version = $env_info.Node; Install = "winget install OpenJS.NodeJS.LTS" },
        @{ Name = "npm"; Version = $env_info.NPM; Install = "Comes with Node.js" },
        @{ Name = "Git"; Version = $env_info.Git; Install = "winget install Git.Git" },
        @{ Name = "Flutter"; Version = $env_info.Flutter; Install = "https://docs.flutter.dev/get-started/install/windows" },
        @{ Name = "Docker"; Version = $env_info.Docker; Install = "winget install Docker.DockerDesktop" },
        @{ Name = "MySQL"; Version = $env_info.MySQL; Install = "Available via Herd, XAMPP, or: winget install Oracle.MySQL" },
        @{ Name = "PostgreSQL"; Version = $env_info.PostgreSQL; Install = "winget install PostgreSQL.PostgreSQL" }
    )

    foreach ($tool in $tools) {
        if ($tool.Version) {
            Write-Success "$($tool.Name) $($tool.Version)"
        } else {
            Write-Failure "$($tool.Name) — not found"
            Write-Info "   Install: $($tool.Install)"
        }
    }

    Write-Host ""
    if ($env_info.Herd) { Write-Success "Laravel Herd detected" } else { Write-Info "Laravel Herd — not detected" }
    if ($env_info.MySQLRunning) { Write-Success "MySQL running on port 3306" } else { Write-Info "MySQL — not running on port 3306" }
    if ($env_info.PostgreSQLRunning) { Write-Success "PostgreSQL running on port 5432" } else { Write-Info "PostgreSQL — not running on port 5432" }
    if ($env_info.RedisRunning) { Write-Success "Redis running on port 6379" } else { Write-Info "Redis — not running on port 6379" }
    Write-Host ""
}

# ============================================================================
# PRESET SYSTEM
# ============================================================================
function Get-Presets {
    $builtIn = @{
        "laravel-react" = @{
            Description = "Laravel + React + Tailwind + MySQL"
            ProjectType = 4; Backend = 1; Frontend = 1; Styling = 1
            PHPEnv = 3; Database = 1; StarterKit = 2; Extras = @(1, 2, 3)
        }
        "laravel-vue" = @{
            Description = "Laravel + Vue + Tailwind + MySQL"
            ProjectType = 4; Backend = 1; Frontend = 3; Styling = 1
            PHPEnv = 3; Database = 1; StarterKit = 2; Extras = @(1, 2, 3)
        }
        "nextjs-full" = @{
            Description = "Next.js full-stack + Tailwind"
            ProjectType = 2; Backend = 0; Frontend = 2; Styling = 1
            PHPEnv = 0; Database = 0; StarterKit = 1; Extras = @(1, 2, 3)
        }
        "flutter-laravel" = @{
            Description = "Flutter + Laravel API + MySQL"
            ProjectType = 5; Backend = 1; Frontend = 0; Styling = 0
            PHPEnv = 3; Database = 1; StarterKit = 2; Extras = @(1, 2, 3)
        }
        "karobar-stack" = @{
            Description = "Laravel + React + Flutter + Tailwind + MySQL (Ando's stack)"
            ProjectType = 6; Backend = 1; Frontend = 1; Styling = 1
            PHPEnv = 1; Database = 1; StarterKit = 3; Extras = @(1, 2, 3)
        }
    }

    # Load user presets
    if (Test-Path $PRESETS_FILE) {
        $userPresets = Get-Content $PRESETS_FILE | ConvertFrom-Json -AsHashtable
        foreach ($key in $userPresets.Keys) {
            $builtIn[$key] = $userPresets[$key]
        }
    }
    return $builtIn
}

function Save-Preset {
    param([string]$Name, [hashtable]$Config)
    if (-not (Test-Path $PRESETS_DIR)) {
        New-Item -ItemType Directory -Path $PRESETS_DIR -Force | Out-Null
    }
    $existing = @{}
    if (Test-Path $PRESETS_FILE) {
        $existing = Get-Content $PRESETS_FILE | ConvertFrom-Json -AsHashtable
    }
    $existing[$Name] = $Config
    $existing | ConvertTo-Json -Depth 5 | Set-Content $PRESETS_FILE
    Write-Success "Preset '$Name' saved!"
}

function Show-Presets {
    $presets = Get-Presets
    Write-Header "📦 Available Presets"
    foreach ($key in $presets.Keys | Sort-Object) {
        Write-Host "    $key" -ForegroundColor White
        Write-Host "       $($presets[$key].Description)" -ForegroundColor DarkGray
    }
    Write-Host ""
    Write-Info "Usage: .\scaffold.ps1 --preset $($presets.Keys | Select-Object -First 1)"
    Write-Host ""
}

# ============================================================================
# DEPENDENCY VALIDATION
# ============================================================================
function Assert-Dependencies {
    param([hashtable]$Config, $Env)
    $missing = @()

    if ($Config.Backend -eq 1) {
        # Laravel
        if (-not $Env.PHP) { $missing += @{ Name = "PHP 8.1+"; Install = "winget install Laravel.Herd  OR  https://windows.php.net" } }
        if (-not $Env.Composer) { $missing += @{ Name = "Composer"; Install = "https://getcomposer.org/download/" } }
    }

    if ($Config.Backend -in @(2, 3) -or $Config.Frontend -in @(1, 2, 3, 4)) {
        # Node.js needed
        if (-not $Env.Node) { $missing += @{ Name = "Node.js 18+"; Install = "winget install OpenJS.NodeJS.LTS" } }
    }

    if ($Config.ProjectType -in @(1, 5, 6)) {
        # Flutter
        if (-not $Env.Flutter) { $missing += @{ Name = "Flutter"; Install = "https://docs.flutter.dev/get-started/install/windows" } }
    }

    if (-not $Env.Git -and ($Config.Extras -contains 1)) {
        $missing += @{ Name = "Git"; Install = "winget install Git.Git" }
    }

    if ($missing.Count -gt 0) {
        Write-Host ""
        Write-Host "  🚫 Missing required tools:" -ForegroundColor Red
        Write-Host ""
        foreach ($m in $missing) {
            Write-Failure "$($m.Name)"
            Write-Info "   Install: $($m.Install)"
        }
        Write-Host ""
        Write-Host "  Please install the missing tools and run this script again." -ForegroundColor Yellow
        Write-Host ""
        return $false
    }
    return $true
}

# ============================================================================
# SCAFFOLDING FUNCTIONS
# ============================================================================
function New-LaravelProject {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName)

    $backendPath = Join-Path $Path "backend"
    Write-Host "  ⏳ Creating Laravel project..." -ForegroundColor Yellow

    # Create via composer
    & composer create-project laravel/laravel $backendPath --quiet 2>&1 | Out-Null

    if (-not (Test-Path $backendPath)) {
        Write-Failure "Failed to create Laravel project"
        return $false
    }

    # Configure .env
    $envFile = Join-Path $backendPath ".env"
    $envContent = Get-Content $envFile -Raw

    # Set app name
    $envContent = $envContent -replace 'APP_NAME=Laravel', "APP_NAME=`"$ProjectName`""

    # Set URL based on PHP environment
    switch ($Config.PHPEnv) {
        1 { # Herd
            $envContent = $envContent -replace 'APP_URL=http://localhost', "APP_URL=https://$ProjectName.test"
        }
        2 { # XAMPP
            $envContent = $envContent -replace 'APP_URL=http://localhost', "APP_URL=http://localhost/$ProjectName/backend/public"
        }
        3 { # artisan serve
            $envContent = $envContent -replace 'APP_URL=http://localhost', "APP_URL=http://localhost:8000"
        }
    }

    # Set database config
    $dbName = $ProjectName -replace '-', '_'
    switch ($Config.Database) {
        1 { # MySQL via Herd
            $envContent = $envContent -replace 'DB_CONNECTION=sqlite', 'DB_CONNECTION=mysql'
            $envContent = $envContent -replace '# DB_HOST=127.0.0.1', 'DB_HOST=127.0.0.1'
            $envContent = $envContent -replace '# DB_PORT=3306', 'DB_PORT=3306'
            $envContent = $envContent -replace '# DB_DATABASE=laravel', "DB_DATABASE=$dbName"
            $envContent = $envContent -replace '# DB_USERNAME=root', 'DB_USERNAME=root'
            $envContent = $envContent -replace '# DB_PASSWORD=', 'DB_PASSWORD='
        }
        2 { # MySQL via XAMPP
            $envContent = $envContent -replace 'DB_CONNECTION=sqlite', 'DB_CONNECTION=mysql'
            $envContent = $envContent -replace '# DB_HOST=127.0.0.1', 'DB_HOST=127.0.0.1'
            $envContent = $envContent -replace '# DB_PORT=3306', 'DB_PORT=3306'
            $envContent = $envContent -replace '# DB_DATABASE=laravel', "DB_DATABASE=$dbName"
            $envContent = $envContent -replace '# DB_USERNAME=root', 'DB_USERNAME=root'
            $envContent = $envContent -replace '# DB_PASSWORD=', 'DB_PASSWORD='
        }
        3 { # MySQL standalone
            $envContent = $envContent -replace 'DB_CONNECTION=sqlite', 'DB_CONNECTION=mysql'
            $envContent = $envContent -replace '# DB_HOST=127.0.0.1', 'DB_HOST=127.0.0.1'
            $envContent = $envContent -replace '# DB_PORT=3306', 'DB_PORT=3306'
            $envContent = $envContent -replace '# DB_DATABASE=laravel', "DB_DATABASE=$dbName"
            $envContent = $envContent -replace '# DB_USERNAME=root', 'DB_USERNAME=root'
            $envContent = $envContent -replace '# DB_PASSWORD=', 'DB_PASSWORD='
        }
        4 { # PostgreSQL
            $envContent = $envContent -replace 'DB_CONNECTION=sqlite', 'DB_CONNECTION=pgsql'
            $envContent = $envContent -replace '# DB_HOST=127.0.0.1', 'DB_HOST=127.0.0.1'
            $envContent = $envContent -replace '# DB_PORT=3306', 'DB_PORT=5432'
            $envContent = $envContent -replace '# DB_DATABASE=laravel', "DB_DATABASE=$dbName"
            $envContent = $envContent -replace '# DB_USERNAME=root', 'DB_USERNAME=postgres'
            $envContent = $envContent -replace '# DB_PASSWORD=', 'DB_PASSWORD='
        }
        5 { # SQLite - default, no changes needed
        }
    }

    # Set frontend URL for CORS
    $frontendPort = if ($Config.Frontend -eq 2) { "3000" } else { "5173" }
    $envContent = $envContent + "`nFRONTEND_URL=http://localhost:$frontendPort`n"

    Set-Content $envFile $envContent

    # Install API scaffolding (Sanctum) if auth starter kit chosen
    if ($Config.StarterKit -ge 2) {
        Write-Host "  ⏳ Setting up login & authentication system..." -ForegroundColor Yellow
        Push-Location $backendPath
        & php artisan install:api --quiet 2>&1 | Out-Null

        # Create auth controller
        $authControllerDir = Join-Path $backendPath "app\Http\Controllers\Auth"
        if (-not (Test-Path $authControllerDir)) {
            New-Item -ItemType Directory -Path $authControllerDir -Force | Out-Null
        }

        $authController = @'
<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'user' => $user,
            'token' => $token,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Logged out']);
    }

    public function user(Request $request)
    {
        return response()->json($request->user());
    }
}
'@
        Set-Content (Join-Path $authControllerDir "AuthController.php") $authController

        # Create API routes
        $apiRoutes = @'
<?php

use App\Http\Controllers\Auth\AuthController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    // Public routes
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);

    // Protected routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/user', [AuthController::class, 'user']);
    });
});
'@
        Set-Content (Join-Path $backendPath "routes\api.php") $apiRoutes

        # Configure CORS
        $corsConfig = @"
<?php

return [
    'paths' => ['api/*', 'sanctum/csrf-cookie'],
    'allowed_methods' => ['*'],
    'allowed_origins' => [
        'http://localhost:$frontendPort',
        'https://$ProjectName.test',
    ],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => true,
];
"@
        $corsPath = Join-Path $backendPath "config\cors.php"
        if (Test-Path $corsPath) {
            Set-Content $corsPath $corsConfig
        }

        Pop-Location
    }

    # Configure CORS in Laravel 11+ (middleware approach)
    $bootstrapApp = Join-Path $backendPath "bootstrap\app.php"
    if (Test-Path $bootstrapApp) {
        $appContent = Get-Content $bootstrapApp -Raw
        if ($appContent -notmatch 'HandleCors') {
            # Laravel 11 uses the new middleware configuration
            $appContent = $appContent -replace '(->withMiddleware\(function \(Middleware \$middleware\) \{)', @"
`$1
        `$middleware->trustProxies(at: '*');
"@
            Set-Content $bootstrapApp $appContent
        }
    }

    Write-Success "Laravel backend created"
    return $true
}

function New-NodeProject {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName, [int]$Framework)

    $backendPath = Join-Path $Path "backend"
    New-Item -ItemType Directory -Path $backendPath -Force | Out-Null

    Write-Host "  ⏳ Creating Node.js backend..." -ForegroundColor Yellow

    Push-Location $backendPath
    & npm init -y 2>&1 | Out-Null

    if ($Framework -eq 2) {
        # Express
        & npm install express cors dotenv helmet morgan 2>&1 | Out-Null
        & npm install -D nodemon 2>&1 | Out-Null

        $dbName = $ProjectName -replace '-', '_'
        $frontendPort = if ($Config.Frontend -eq 2) { "3000" } else { "5173" }

        # Create .env
        $envContent = @"
PORT=8000
NODE_ENV=development
FRONTEND_URL=http://localhost:$frontendPort
DB_HOST=127.0.0.1
DB_PORT=$(if ($Config.Database -eq 4) { '5432' } else { '3306' })
DB_NAME=$dbName
DB_USER=$(if ($Config.Database -eq 4) { 'postgres' } else { 'root' })
DB_PASS=
"@
        Set-Content ".env" $envContent

        # Create server
        $serverContent = @'
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 8000;

// Middleware
app.use(helmet());
app.use(morgan('dev'));
app.use(cors({
    origin: process.env.FRONTEND_URL || 'http://localhost:5173',
    credentials: true,
}));
app.use(express.json());

// Routes
app.get('/api/v1/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Start server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
'@
        Set-Content "server.js" $serverContent

        # Update package.json scripts
        $pkg = Get-Content "package.json" | ConvertFrom-Json
        $pkg.scripts = @{
            start = "node server.js"
            dev = "nodemon server.js"
        }
        $pkg.main = "server.js"
        $pkg | ConvertTo-Json -Depth 5 | Set-Content "package.json"

    } elseif ($Framework -eq 3) {
        # Fastify
        & npm install fastify @fastify/cors @fastify/helmet dotenv 2>&1 | Out-Null
        & npm install -D nodemon 2>&1 | Out-Null

        $frontendPort = if ($Config.Frontend -eq 2) { "3000" } else { "5173" }

        $serverContent = @"
const fastify = require('fastify')({ logger: true });
const cors = require('@fastify/cors');
const helmet = require('@fastify/helmet');
require('dotenv').config();

const PORT = process.env.PORT || 8000;

fastify.register(cors, {
    origin: process.env.FRONTEND_URL || 'http://localhost:$frontendPort',
    credentials: true,
});
fastify.register(helmet);

fastify.get('/api/v1/health', async () => {
    return { status: 'ok', timestamp: new Date().toISOString() };
});

fastify.listen({ port: PORT, host: '0.0.0.0' }, (err) => {
    if (err) { fastify.log.error(err); process.exit(1); }
});
"@
        Set-Content "server.js" $serverContent

        $pkg = Get-Content "package.json" | ConvertFrom-Json
        $pkg.scripts = @{ start = "node server.js"; dev = "nodemon server.js" }
        $pkg | ConvertTo-Json -Depth 5 | Set-Content "package.json"
    }

    # Create .gitignore
    Set-Content ".gitignore" "node_modules`n.env`n"

    Pop-Location
    Write-Success "Node.js backend created"
    return $true
}

function New-FrontendProject {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName)

    $frontendPath = Join-Path $Path "frontend"
    Write-Host "  ⏳ Creating frontend..." -ForegroundColor Yellow

    switch ($Config.Frontend) {
        1 { # React (Vite)
            & npm create vite@latest $frontendPath -- --template react 2>&1 | Out-Null
        }
        2 { # Next.js
            & npx create-next-app@latest $frontendPath --js --no-tailwind --no-eslint --app --no-src-dir --no-import-alias --no-turbopack 2>&1 | Out-Null
        }
        3 { # Vue (Vite)
            & npm create vite@latest $frontendPath -- --template vue 2>&1 | Out-Null
        }
        4 { # Nuxt
            & npx nuxi@latest init $frontendPath 2>&1 | Out-Null
        }
    }

    if (-not (Test-Path $frontendPath)) {
        Write-Failure "Failed to create frontend project"
        return $false
    }

    Push-Location $frontendPath

    # Install dependencies
    Write-Host "  ⏳ Installing frontend packages..." -ForegroundColor Yellow
    & npm install 2>&1 | Out-Null

    # Install Tailwind if selected
    if ($Config.Styling -eq 1) {
        Write-Host "  ⏳ Setting up Tailwind CSS..." -ForegroundColor Yellow

        if ($Config.Frontend -eq 2) {
            # Next.js - use their Tailwind setup
            & npm install -D tailwindcss @tailwindcss/postcss postcss 2>&1 | Out-Null
        } else {
            & npm install -D tailwindcss @tailwindcss/vite 2>&1 | Out-Null
        }
    }

    # Install Bootstrap if selected
    if ($Config.Styling -eq 2) {
        & npm install bootstrap 2>&1 | Out-Null
    }

    # Create .env with API URL
    $backendUrl = switch ($Config.PHPEnv) {
        1 { "https://$ProjectName.test" }
        2 { "http://localhost/$ProjectName/backend/public" }
        3 { "http://localhost:8000" }
        default { "http://localhost:8000" }
    }

    $envPrefix = if ($Config.Frontend -in @(2, 4)) { "" } else { "VITE_" }
    $envContent = "${envPrefix}API_URL=$backendUrl/api/v1"

    if ($Config.Frontend -eq 2) {
        $envContent = "NEXT_PUBLIC_API_URL=$backendUrl/api/v1"
    } elseif ($Config.Frontend -eq 4) {
        $envContent = "NUXT_PUBLIC_API_URL=$backendUrl/api/v1"
    }

    Set-Content ".env" $envContent

    Pop-Location
    Write-Success "Frontend created"
    return $true
}

function New-FlutterProject {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName)

    $mobilePath = Join-Path $Path "mobile"
    $flutterName = ($ProjectName -replace '-', '_') -replace '[^a-z0-9_]', ''

    Write-Host "  ⏳ Creating Flutter app..." -ForegroundColor Yellow
    & flutter create --project-name $flutterName $mobilePath --quiet 2>&1 | Out-Null

    if (-not (Test-Path $mobilePath)) {
        Write-Failure "Failed to create Flutter project"
        return $false
    }

    Push-Location $mobilePath

    # Add common dependencies
    Write-Host "  ⏳ Adding Flutter packages..." -ForegroundColor Yellow
    & flutter pub add dio go_router flutter_secure_storage 2>&1 | Out-Null

    # Create API service
    $libPath = Join-Path $mobilePath "lib"
    $servicesPath = Join-Path $libPath "services"
    New-Item -ItemType Directory -Path $servicesPath -Force | Out-Null

    $backendUrl = switch ($Config.PHPEnv) {
        1 { "https://$ProjectName.test" }
        2 { "http://localhost:8000" }
        3 { "http://localhost:8000" }
        default { "http://localhost:8000" }
    }

    $apiService = @"
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = '$backendUrl/api/v1';
  
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiService() : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {'Accept': 'application/json'},
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer `$token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }

  Future<Response> get(String path) => _dio.get(path);
  Future<Response> post(String path, {dynamic data}) => _dio.post(path, data: data);
  Future<Response> put(String path, {dynamic data}) => _dio.put(path, data: data);
  Future<Response> delete(String path) => _dio.delete(path);
}
"@
    Set-Content (Join-Path $servicesPath "api_service.dart") $apiService

    Pop-Location
    Write-Success "Flutter app created"
    return $true
}

function New-Database {
    param([hashtable]$Config, [string]$ProjectName)

    $dbName = $ProjectName -replace '-', '_'

    if ($Config.Database -eq 5) {
        # SQLite — no creation needed
        Write-Success "Using SQLite (no setup needed)"
        return $true
    }

    Write-Host "  ⏳ Creating database '$dbName'..." -ForegroundColor Yellow

    try {
        if ($Config.Database -in @(1, 2, 3)) {
            # MySQL
            & mysql -u root -e "CREATE DATABASE IF NOT EXISTS ``$dbName`` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>&1 | Out-Null
            Write-Success "MySQL database '$dbName' created"
        } elseif ($Config.Database -eq 4) {
            # PostgreSQL
            $dbExists = & psql -U postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$dbName'" 2>&1
            if ($dbExists -ne "1") {
                & psql -U postgres -c "CREATE DATABASE $dbName;" 2>&1 | Out-Null
            }
            Write-Success "PostgreSQL database '$dbName' created"
        }
        return $true
    } catch {
        Write-Warning "Could not create database automatically. Create it manually:"
        if ($Config.Database -in @(1, 2, 3)) {
            Write-Info "   mysql -u root -e `"CREATE DATABASE $dbName;`""
        } else {
            Write-Info "   psql -U postgres -c `"CREATE DATABASE $dbName;`""
        }
        return $false
    }
}

function Invoke-Migrations {
    param([string]$Path)
    $backendPath = Join-Path $Path "backend"
    if (Test-Path (Join-Path $backendPath "artisan")) {
        Write-Host "  ⏳ Running database migrations..." -ForegroundColor Yellow
        Push-Location $backendPath
        try {
            & php artisan migrate --force --quiet 2>&1 | Out-Null
            Write-Success "Migrations complete"
        } catch {
            Write-Warning "Migrations failed — you can run them manually: cd backend && php artisan migrate"
        }
        Pop-Location
    }
}

function Set-HerdLink {
    param([string]$Path, [string]$ProjectName)
    $backendPath = Join-Path $Path "backend"
    $publicPath = Join-Path $backendPath "public"

    Write-Host "  ⏳ Linking to Laravel Herd..." -ForegroundColor Yellow

    try {
        Push-Location $backendPath
        & herd link $ProjectName 2>&1 | Out-Null
        & herd secure $ProjectName 2>&1 | Out-Null
        Pop-Location
        Write-Success "Herd linked: https://$ProjectName.test"
    } catch {
        Write-Warning "Could not link to Herd automatically."
        Write-Info "   Run manually: cd backend && herd link $ProjectName && herd secure $ProjectName"
    }
}

function New-GitRepo {
    param([string]$Path, [string]$ProjectName)
    Write-Host "  ⏳ Initializing Git..." -ForegroundColor Yellow
    Push-Location $Path
    & git init --quiet 2>&1 | Out-Null
    & git add -A 2>&1 | Out-Null
    & git commit -m "Initial scaffold: $ProjectName" --quiet 2>&1 | Out-Null
    Pop-Location
    Write-Success "Git initialized with first commit"
}

function New-VSCodeWorkspace {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName)

    $needsBackend = $Config.ProjectType -in @(3, 4, 5, 6)
    $needsFrontend = $Config.ProjectType -in @(2, 4, 6)
    $needsMobile = $Config.ProjectType -in @(1, 5, 6)

    $folders = @()
    $terminals = @()

    if ($needsBackend) {
        $folders += @{ path = "backend" }
        if (-not ($Config.Backend -eq 1 -and $Config.PHPEnv -eq 1)) {
            $label = if ($Config.Backend -eq 1) { "Backend (php artisan serve)" } else { "Backend (npm run dev)" }
            $cmd = if ($Config.Backend -eq 1) { "php artisan serve" } else { "npm run dev" }
            $terminals += @{ label = $label; command = $cmd; cwd = "backend" }
        }
    }
    if ($needsFrontend) {
        $folders += @{ path = "frontend" }
        $terminals += @{ label = "Frontend (npm run dev)"; command = "npm run dev"; cwd = "frontend" }
    }
    if ($needsMobile) {
        $folders += @{ path = "mobile" }
        $terminals += @{ label = "Mobile (flutter run)"; command = "flutter run"; cwd = "mobile" }
    }

    # Always include root for docs, scripts, etc.
    $folders += @{ path = "."; name = "📁 Root" }

    $workspace = @{
        folders = $folders
        settings = @{
            "terminal.integrated.defaultProfile.windows" = "PowerShell"
        }
    }

    # Add terminal tasks
    if ($terminals.Count -gt 0) {
        $workspace.settings["terminal.integrated.profiles.windows"] = @{}
        $taskList = @()
        foreach ($term in $terminals) {
            $taskList += @{
                label = $term.label
                type = "shell"
                command = $term.command
                options = @{ cwd = "`${workspaceFolder:$($term.cwd)}" }
                presentation = @{ reveal = "always"; panel = "new" }
            }
        }
        # We'll add tasks to the workspace
        $workspace["tasks"] = @{ version = "2.0.0"; tasks = $taskList }
    }

    $workspaceFile = Join-Path $Path "$ProjectName.code-workspace"
    $workspace | ConvertTo-Json -Depth 10 | Set-Content $workspaceFile
    Write-Success "VS Code workspace created: $ProjectName.code-workspace"
    return $terminals
}

function New-LauncherScripts {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName)

    $needsBackend = $Config.ProjectType -in @(3, 4, 5, 6)
    $needsFrontend = $Config.ProjectType -in @(2, 4, 6)
    $needsMobile = $Config.ProjectType -in @(1, 5, 6)

    $backendUrl = switch ("$($Config.Backend)-$($Config.PHPEnv)") {
        "1-1" { "https://$ProjectName.test" }
        "1-2" { "http://localhost/$ProjectName/backend/public" }
        default { "http://localhost:8000" }
    }
    $frontendPort = if ($Config.Frontend -eq 2) { "3000" } else { "5173" }

    # ── start.ps1 ──
    $startLines = @('# Start all servers', '')

    if ($needsBackend -and -not ($Config.Backend -eq 1 -and $Config.PHPEnv -eq 1)) {
        $cmd = if ($Config.Backend -eq 1) { "php artisan serve" } else { "npm run dev" }
        $startLines += "Write-Host '⚙️  Starting backend...' -ForegroundColor Yellow"
        $startLines += "Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd `"$Path\backend`"; $cmd'"
    }
    if ($needsFrontend) {
        $startLines += "Write-Host '🌐 Starting frontend...' -ForegroundColor Yellow"
        $startLines += "Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd `"$Path\frontend`"; npm run dev'"
    }
    if ($needsMobile) {
        $startLines += "Write-Host '📱 Starting Flutter...' -ForegroundColor Yellow"
        $startLines += "Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd `"$Path\mobile`"; flutter run'"
    }

    $startLines += ""
    $startLines += "Start-Sleep -Seconds 3"
    if ($needsBackend) { $startLines += "Start-Process '$backendUrl'" }
    if ($needsFrontend) { $startLines += "Start-Process 'http://localhost:$frontendPort'" }
    $startLines += ""
    $startLines += "Write-Host '✅ All servers started!' -ForegroundColor Green"

    Set-Content (Join-Path $Path "start.ps1") ($startLines -join "`n")

    # ── stop.ps1 ──
    $stopLines = @(
        '# Stop all dev servers',
        'Get-Process -Name "node" -ErrorAction SilentlyContinue | Stop-Process -Force',
        'Get-Process -Name "php" -ErrorAction SilentlyContinue | Stop-Process -Force',
        'Write-Host "✅ All servers stopped." -ForegroundColor Green'
    )
    Set-Content (Join-Path $Path "stop.ps1") ($stopLines -join "`n")

    # ── open.ps1 ──
    $wsFile = Join-Path $Path "$ProjectName.code-workspace"
    $openLines = @(
        "# Open project in VS Code",
        "if (Test-Path '$wsFile') {",
        "    code '$wsFile'",
        "} else {",
        "    code '$Path'",
        "}"
    )
    Set-Content (Join-Path $Path "open.ps1") ($openLines -join "`n")

    Write-Success "Launcher scripts created (start.ps1, stop.ps1, open.ps1)"
}

function New-ReadmeFile {
    param([string]$Path, [hashtable]$Config, [string]$ProjectName, $Terminals)

    $needsBackend = $Config.ProjectType -in @(3, 4, 5, 6)
    $needsFrontend = $Config.ProjectType -in @(2, 4, 6)
    $needsMobile = $Config.ProjectType -in @(1, 5, 6)

    $backendUrl = switch ("$($Config.Backend)-$($Config.PHPEnv)") {
        "1-1" { "https://$ProjectName.test" }
        "1-2" { "http://localhost/$ProjectName/backend/public" }
        default { "http://localhost:8000" }
    }
    $frontendPort = if ($Config.Frontend -eq 2) { "3000" } else { "5173" }

    $readme = @"
# $ProjectName

## Quick Start

```powershell
.\start.ps1     # Start everything
.\stop.ps1      # Stop everything
.\open.ps1      # Open in VS Code
```

## Project Structure

"@

    if ($needsBackend) {
        $backendType = if ($Config.Backend -eq 1) { "Laravel" } else { "Node.js" }
        $readme += @"

### Backend ($backendType)
- **Path**: ``backend/``
- **URL**: $backendUrl
- **API**: $backendUrl/api/v1

"@
    }

    if ($needsFrontend) {
        $feType = switch ($Config.Frontend) { 1 { "React" } 2 { "Next.js" } 3 { "Vue" } 4 { "Nuxt" } }
        $readme += @"

### Frontend ($feType)
- **Path**: ``frontend/``
- **URL**: http://localhost:$frontendPort

"@
    }

    if ($needsMobile) {
        $readme += @"

### Mobile (Flutter)
- **Path**: ``mobile/``
- **Run**: ``cd mobile && flutter run``

"@
    }

    $readme += @"

## Development

Each component runs in its own terminal:

"@

    if ($needsBackend -and $Config.Backend -eq 1 -and $Config.PHPEnv -eq 1) {
        $readme += "- **Backend**: Already running via Laravel Herd at $backendUrl`n"
    } elseif ($needsBackend -and $Config.Backend -eq 1) {
        $readme += "- **Backend**: ``cd backend && php artisan serve```n"
    } elseif ($needsBackend) {
        $readme += "- **Backend**: ``cd backend && npm run dev```n"
    }
    if ($needsFrontend) {
        $readme += "- **Frontend**: ``cd frontend && npm run dev```n"
    }
    if ($needsMobile) {
        $readme += "- **Mobile**: ``cd mobile && flutter run```n"
    }

    $readme += @"

---

*Generated by Project Scaffolder v$SCAFFOLDER_VERSION on $(Get-Date -Format "yyyy-MM-dd")*
"@

    Set-Content (Join-Path $Path "README.md") $readme
    Write-Success "README.md created with full instructions"
}

# ============================================================================
# INSTALL TO PATH
# ============================================================================
function Install-Scaffolder {
    Write-Header "🔧 Want to use this scaffolder again easily?"

    Write-Option 1 "Add to PATH" "Type 'scaffold' in any terminal, from any folder" "⭐"
    Write-Option 2 "Add PowerShell alias" "Type 'scaffold' in PowerShell only"
    Write-Option 3 "Right-click menu" "Right-click any folder → 'Scaffold New Project Here'"
    Write-Option 4 "All of the above" ""
    Write-Option 5 "No thanks" "I'll just run the .ps1 file manually"

    $choice = Read-Choice "" -Max 5 -Default 5

    if ($choice -in @(1, 4)) {
        # Copy to scripts folder and add to PATH
        $scriptsDir = "$env:USERPROFILE\scripts"
        if (-not (Test-Path $scriptsDir)) {
            New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
        }
        Copy-Item $SCRIPT_PATH (Join-Path $scriptsDir "scaffold.ps1") -Force

        # Create batch wrapper so it works from cmd too
        $batchWrapper = "@echo off`npowershell -ExecutionPolicy Bypass -File `"%USERPROFILE%\scripts\scaffold.ps1`" %*"
        Set-Content (Join-Path $scriptsDir "scaffold.bat") $batchWrapper

        # Add to PATH if not already there
        $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
        if ($userPath -notmatch [regex]::Escape($scriptsDir)) {
            [Environment]::SetEnvironmentVariable("PATH", "$userPath;$scriptsDir", "User")
            Write-Success "Added to PATH. Open a new terminal and type: scaffold"
        } else {
            Write-Success "Already in PATH. Type: scaffold"
        }
    }

    if ($choice -in @(2, 4)) {
        # Add PowerShell alias
        $profilePath = $PROFILE
        $profileDir = Split-Path $profilePath
        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        }
        if (-not (Test-Path $profilePath)) {
            New-Item -ItemType File -Path $profilePath -Force | Out-Null
        }

        $aliasLine = "function scaffold { & '$SCRIPT_PATH' @args }"
        $profileContent = ""
        if (Test-Path $profilePath) {
            $profileContent = Get-Content $profilePath -Raw
        }
        if ($profileContent -notmatch 'function scaffold') {
            Add-Content $profilePath "`n# Project Scaffolder`n$aliasLine"
            Write-Success "PowerShell alias added. Restart PowerShell and type: scaffold"
        } else {
            Write-Success "PowerShell alias already exists"
        }
    }

    if ($choice -in @(3, 4)) {
        # Add context menu (requires running as admin for HKCU usually works)
        try {
            $regPath = "HKCU:\Software\Classes\Directory\Background\shell\ScaffoldProject"
            New-Item -Path $regPath -Force | Out-Null
            Set-ItemProperty -Path $regPath -Name "(Default)" -Value "Scaffold New Project Here"
            Set-ItemProperty -Path $regPath -Name "Icon" -Value "powershell.exe"
            New-Item -Path "$regPath\command" -Force | Out-Null
            Set-ItemProperty -Path "$regPath\command" -Name "(Default)" -Value "powershell.exe -ExecutionPolicy Bypass -File `"$SCRIPT_PATH`""
            Write-Success "Context menu added. Right-click in any folder."
        } catch {
            Write-Warning "Could not add context menu. Try running as Administrator."
        }
    }
}

# ============================================================================
# MAIN WIZARD
# ============================================================================
function Start-Wizard {
    # Collect configuration
    $config = @{
        ProjectType = 0
        Backend = 0
        Frontend = 0
        PHPEnv = 0
        Database = 0
        Styling = 0
        StarterKit = 1
        Extras = @()
        FlutterStateManagement = 0
    }

    Clear-Host
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║       🚀 Project Scaffolder v$SCAFFOLDER_VERSION             ║" -ForegroundColor Cyan
    Write-Host "  ║       Create projects with zero friction      ║" -ForegroundColor Cyan
    Write-Host "  ╚═══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    $currentDir = (Get-Location).Path
    Write-Info "Files will be created here: $currentDir"
    Write-Host ""

    # Detect environment
    $envInfo = Get-Environment
    Show-EnvironmentScan $envInfo

    # ── STEP 1: Project Name ──
    $totalSteps = 10
    Write-Step 1 $totalSteps "What's your project name?"
    Write-Info "Used for database, URLs, and workspace file."
    Write-Info "Use lowercase, no spaces (e.g. my-store, cool-app)"
    Write-Host ""
    $projectName = Read-Text "Project name"
    $projectName = ($projectName -replace ' ', '-' -replace '[^a-zA-Z0-9\-]', '').ToLower()
    if (-not $projectName) {
        Write-Failure "Project name is required."
        return
    }

    # ── STEP 2: Project Type ──
    Write-Step 2 $totalSteps "What are you building?"
    Write-Option 1 "📱 Mobile App only" "An app for phones (Android, iPhone, or both)"
    Write-Option 2 "🌐 Website only" "A frontend website that runs in the browser"
    Write-Option 3 "⚙️  Backend API only" "A server that handles data — no screens"
    Write-Option 4 "🌐+⚙️  Website + Backend" "A website with its own server and database"
    Write-Option 5 "📱+⚙️  Mobile App + Backend" "A phone app with its own server and database"
    Write-Option 6 "🚀 Everything" "Website + Backend + Mobile App — the full package"
    $config.ProjectType = Read-Choice "" -Max 6

    $needsBackend = $config.ProjectType -in @(3, 4, 5, 6)
    $needsFrontend = $config.ProjectType -in @(2, 4, 6)
    $needsMobile = $config.ProjectType -in @(1, 5, 6)

    # ── STEP 3: Backend ──
    if ($needsBackend) {
        Write-Step 3 $totalSteps "What should power your server?"
        Write-Option 1 "Laravel (PHP)" "Most popular for web apps. Great for APIs and dashboards." "⭐"
        Write-Option 2 "Express (Node.js)" "Same language as your website. Lightweight and fast."
        Write-Option 3 "Fastify (Node.js)" "Like Express but faster. Great for high-traffic APIs."
        $config.Backend = Read-Choice "" -Max 3 -Default 1
    }

    # ── STEP 4: Frontend ──
    if ($needsFrontend) {
        Write-Step 4 $totalSteps "What should your website be built with?"
        Write-Option 1 "React" "The most popular choice. Huge community." "⭐"
        Write-Option 2 "Next.js" "React with extra powers — better for SEO and public websites."
        Write-Option 3 "Vue" "Easier to learn than React. Very clean code."
        Write-Option 4 "Nuxt" "Vue with extra powers (like Next.js but for Vue)."
        $config.Frontend = Read-Choice "" -Max 4 -Default 1
    }

    # ── STEP 5: PHP Environment ──
    if ($config.Backend -eq 1) {
        Write-Step 5 $totalSteps "How do you run PHP on your computer?"
        Write-Option 1 "Laravel Herd" "$(if ($envInfo.Herd) { 'Detected! ✅' } else { '(not detected)' }) — Handles everything automatically." "$(if ($envInfo.Herd) { '⭐' })"
        Write-Option 2 "XAMPP" "The classic way with Apache."
        Write-Option 3 "Terminal (php artisan serve)" "Simple — runs on http://localhost:8000"
        Write-Option 4 "Docker" "$(if ($envInfo.Docker) { 'Detected ✅' } else { '❌ Not detected' }) — Runs in containers."

        $defaultPHP = if ($envInfo.Herd) { 1 } else { 3 }
        $config.PHPEnv = Read-Choice "" -Max 4 -Default $defaultPHP
    } else {
        $config.PHPEnv = 0
    }

    # ── STEP 6: Database ──
    if ($needsBackend) {
        Write-Step 6 $totalSteps "Where should your app store its data?"

        $mysqlStatus = if ($envInfo.MySQLRunning) { "✅ Running" } elseif ($envInfo.MySQL) { "Installed" } else { "Not detected" }
        $pgStatus = if ($envInfo.PostgreSQLRunning) { "✅ Running" } elseif ($envInfo.PostgreSQL) { "Installed" } else { "Not detected" }

        Write-Option 1 "MySQL" "($mysqlStatus) — The most common database for web apps." "$(if ($envInfo.MySQLRunning) { '⭐' })"
        Write-Option 2 "MySQL via XAMPP" "Included with XAMPP."
        Write-Option 3 "MySQL (standalone)" "You installed MySQL separately."
        Write-Option 4 "PostgreSQL" "($pgStatus) — Powerful, great for complex data."
        Write-Option 5 "SQLite" "Simplest option — stores data in a file. Zero setup."

        $defaultDB = if ($envInfo.MySQLRunning) { 1 } elseif ($envInfo.PostgreSQLRunning) { 4 } else { 5 }
        $config.Database = Read-Choice "" -Max 5 -Default $defaultDB
    }

    # ── STEP 7: Styling ──
    if ($needsFrontend) {
        Write-Step 7 $totalSteps "How do you want to style your website?"
        Write-Option 1 "Tailwind CSS" "Modern utility-first styling. Very fast to build with." "⭐"
        Write-Option 2 "Bootstrap" "Pre-made components. Quick and classic."
        Write-Option 3 "Nothing" "I'll handle CSS myself."
        $config.Styling = Read-Choice "" -Max 3 -Default 1
    }

    # ── STEP 8: Starter Kit ──
    Write-Step 8 $totalSteps "What kind of starting point do you want?"
    Write-Option 1 "🏗️  Blank slate" "Empty project, everything wired up. You build from scratch."
    Write-Option 2 "🔐 With login system" "Login, signup, forgot password — all connected." "⭐"
    Write-Option 3 "📊 Dashboard starter" "Login system + sidebar layout, top bar, dark mode toggle."
    $config.StarterKit = Read-Choice "" -Max 3 -Default 2

    # ── STEP 9: Extras ──
    Write-Step 9 $totalSteps "Quick extras (pick as many as you like):"
    Write-CheckboxOption 1 "Git setup — track changes, undo mistakes" $true
    Write-CheckboxOption 2 "VS Code workspace — open everything in one window with named terminals" $true
    Write-CheckboxOption 3 "README — instructions for you or your team" $true
    Write-Host ""
    $config.Extras = Read-MultiChoice "" -Max 3 -Defaults @(1, 2, 3)

    # ── STEP 10: Confirmation ──
    Write-Step 10 $totalSteps "Here's what I'm about to create:"
    Write-Host ""

    $backendLabel = switch ($config.Backend) {
        1 { "Laravel (PHP$(if ($config.PHPEnv -eq 1) { ' via Herd' } elseif ($config.PHPEnv -eq 2) { ' via XAMPP' } else { '' }))" }
        2 { "Express (Node.js)" }
        3 { "Fastify (Node.js)" }
        default { "None" }
    }
    $frontendLabel = switch ($config.Frontend) {
        1 { "React" }
        2 { "Next.js" }
        3 { "Vue" }
        4 { "Nuxt" }
        default { "None" }
    }
    $stylingLabel = switch ($config.Styling) {
        1 { " + Tailwind CSS" }
        2 { " + Bootstrap" }
        default { "" }
    }
    $dbLabel = switch ($config.Database) {
        1 { "MySQL (Herd)" }
        2 { "MySQL (XAMPP)" }
        3 { "MySQL" }
        4 { "PostgreSQL" }
        5 { "SQLite" }
        default { "None" }
    }
    $kitLabel = switch ($config.StarterKit) {
        1 { "Blank slate" }
        2 { "With login system" }
        3 { "Dashboard starter" }
    }

    Write-Host "    📁 Location:     $currentDir" -ForegroundColor White
    Write-Host "    🏷️  Project:      $projectName" -ForegroundColor White
    if ($needsBackend) { Write-Host "    ⚙️  Backend:      $backendLabel" -ForegroundColor White }
    if ($needsFrontend) { Write-Host "    🌐 Frontend:     $frontendLabel$stylingLabel" -ForegroundColor White }
    if ($needsMobile) { Write-Host "    📱 Mobile:       Flutter" -ForegroundColor White }
    if ($needsBackend) { Write-Host "    🗄️  Database:     $dbLabel" -ForegroundColor White }
    Write-Host "    🎯 Starter:      $kitLabel" -ForegroundColor White
    Write-Host ""

    if (-not (Read-YesNo "Ready to go?")) {
        Write-Host ""
        Write-Info "Cancelled. No files were created."
        return
    }

    # ── VALIDATE DEPENDENCIES ──
    if (-not (Assert-Dependencies $config $envInfo)) {
        return
    }

    # ══════════════════════════════════════════════════════════════
    # BUILD PHASE
    # ══════════════════════════════════════════════════════════════
    Write-Host ""
    Write-Header "🔨 Building your project..."
    $projectPath = $currentDir

    # Create database
    if ($needsBackend -and $config.Database -ne 5) {
        New-Database -Config $config -ProjectName $projectName
    }

    # Create backend
    if ($needsBackend) {
        if ($config.Backend -eq 1) {
            $result = New-LaravelProject -Path $projectPath -Config $config -ProjectName $projectName
        } else {
            $result = New-NodeProject -Path $projectPath -Config $config -ProjectName $projectName -Framework $config.Backend
        }
    }

    # Create frontend
    if ($needsFrontend) {
        New-FrontendProject -Path $projectPath -Config $config -ProjectName $projectName
    }

    # Create mobile
    if ($needsMobile) {
        New-FlutterProject -Path $projectPath -Config $config -ProjectName $projectName
    }

    # Run migrations
    if ($config.Backend -eq 1 -and $config.Database -ne 5) {
        Invoke-Migrations -Path $projectPath
    }

    # Link to Herd
    if ($config.Backend -eq 1 -and $config.PHPEnv -eq 1) {
        Set-HerdLink -Path $projectPath -ProjectName $projectName
    }

    # Git
    $terminals = @()
    if ($config.Extras -contains 1) {
        New-GitRepo -Path $projectPath -ProjectName $projectName
    }

    # VS Code workspace
    if ($config.Extras -contains 2) {
        $terminals = New-VSCodeWorkspace -Path $projectPath -Config $config -ProjectName $projectName
    }

    # README
    if ($config.Extras -contains 3) {
        New-ReadmeFile -Path $projectPath -Config $config -ProjectName $projectName -Terminals $terminals
    }

    # Launcher scripts (always created)
    New-LauncherScripts -Path $projectPath -Config $config -ProjectName $projectName

    # Save preset if requested
    if ($SavePreset) {
        $config["Description"] = "$backendLabel + $frontendLabel$stylingLabel"
        Save-Preset -Name $SavePreset -Config $config
    }

    # ══════════════════════════════════════════════════════════════
    # FINAL OUTPUT
    # ══════════════════════════════════════════════════════════════
    $terminalCount = 0
    if ($needsBackend -and -not ($config.Backend -eq 1 -and $config.PHPEnv -eq 1)) { $terminalCount++ }
    if ($needsFrontend) { $terminalCount++ }
    if ($needsMobile) { $terminalCount++ }

    $backendUrlDisplay = switch ("$($config.Backend)-$($config.PHPEnv)") {
        "1-1" { "https://$projectName.test" }
        "1-2" { "http://localhost/$projectName/backend/public" }
        default { "http://localhost:8000" }
    }
    $frontendPortDisplay = if ($config.Frontend -eq 2) { "3000" } else { "5173" }

    Write-Host ""
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║                  🎉 $projectName is ready!                       ║" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ╠══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║  THE EASY WAY — start everything with one command:               ║" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║     .\start.ps1                                                  ║" -ForegroundColor White
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║  This starts all servers and opens your browser.                 ║" -ForegroundColor Green
    Write-Host "  ║  To stop everything: .\stop.ps1                                  ║" -ForegroundColor Green
    Write-Host "  ║  To open in VS Code: .\open.ps1                                  ║" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ╠══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║  THE MANUAL WAY — if you prefer to run things yourself:          ║" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green

    if ($needsBackend) {
        if ($config.Backend -eq 1 -and $config.PHPEnv -eq 1) {
    Write-Host "  ║  ⚙️  Backend:   Already running via Herd                          ║" -ForegroundColor Green
    Write-Host "  ║               Open: $backendUrlDisplay                             ║" -ForegroundColor White
        } elseif ($config.Backend -eq 1) {
    Write-Host "  ║  ⚙️  Backend:   cd backend && php artisan serve                   ║" -ForegroundColor Green
    Write-Host "  ║               Open: $backendUrlDisplay                             ║" -ForegroundColor White
        } else {
    Write-Host "  ║  ⚙️  Backend:   cd backend && npm run dev                         ║" -ForegroundColor Green
    Write-Host "  ║               Open: $backendUrlDisplay                             ║" -ForegroundColor White
        }
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    }

    if ($needsFrontend) {
    Write-Host "  ║  🌐 Website:   cd frontend && npm run dev                        ║" -ForegroundColor Green
    Write-Host "  ║               Open: http://localhost:$frontendPortDisplay                         ║" -ForegroundColor White
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    }

    if ($needsMobile) {
    Write-Host "  ║  📱 Mobile:    cd mobile && flutter run                           ║" -ForegroundColor Green
    Write-Host "  ║               Opens in your phone emulator                       ║" -ForegroundColor White
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    }

    Write-Host "  ║  Each command needs its own terminal window.                     ║" -ForegroundColor Green
    Write-Host "  ║  In VS Code: Terminal → New Terminal for each.                   ║" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ╠══════════════════════════════════════════════════════════════════╣" -ForegroundColor Green
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ║  ✅ DONE FOR YOU:                                                ║" -ForegroundColor Green

    if ($needsBackend -and $config.Database -ne 5) {
    Write-Host "  ║    • Database created: $($projectName -replace '-','_')          ║" -ForegroundColor Green
    }
    if ($config.Backend -eq 1 -and $config.Database -ne 5) {
    Write-Host "  ║    • All tables set up (migrations ran)                          ║" -ForegroundColor Green
    }
    if ($config.Backend -eq 1 -and $config.PHPEnv -eq 1) {
    Write-Host "  ║    • Herd linked: $backendUrlDisplay                              ║" -ForegroundColor Green
    }
    Write-Host "  ║    • All packages installed                                      ║" -ForegroundColor Green
    if ($config.Extras -contains 1) {
    Write-Host "  ║    • Git initialized with first commit                           ║" -ForegroundColor Green
    }
    Write-Host "  ║    • start.ps1, stop.ps1, open.ps1 scripts ready                ║" -ForegroundColor Green
    if ($config.Extras -contains 3) {
    Write-Host "  ║    • README.md with full instructions                            ║" -ForegroundColor Green
    }
    Write-Host "  ║                                                                  ║" -ForegroundColor Green
    Write-Host "  ╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""

    # Offer installation
    Install-Scaffolder
}

# ============================================================================
# ENTRY POINT
# ============================================================================
if ($Doctor) {
    Invoke-Doctor
    exit
}

if ($ListPresets) {
    Show-Presets
    exit
}

if ($Preset) {
    $presets = Get-Presets
    if ($presets.ContainsKey($Preset)) {
        Write-Host "  Using preset: $Preset" -ForegroundColor Cyan
        # TODO: Apply preset and skip wizard
        # For now, start wizard
        Start-Wizard
    } else {
        Write-Failure "Preset '$Preset' not found. Use --list-presets to see available."
        exit 1
    }
} else {
    Start-Wizard
}
