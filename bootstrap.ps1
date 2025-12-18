# Check for admin rights
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "⚠️  This script requires Administrator privileges." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    return
}

Write-Host "🚀 Starting bootstrap setup for Windows..." -ForegroundColor Cyan

# --- Check if Chocolatey is installed ---
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "✅ Chocolatey already installed" -ForegroundColor Green
}

# --- Install tools ---
Write-Host "📦 Installing development tools..." -ForegroundColor Yellow
choco install -y git neovim nodejs lazygit ripgrep fd fzf bat zoxide

# --- Check for Nerd Font (check system fonts, not just user fonts) ---
$systemFontDir = "C:\Windows\Fonts"
$userFontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

$requiredFonts = @(
    "JetBrainsMonoNLNerdFont-Regular.ttf",
    "JetBrainsMonoNLNerdFont-Bold.ttf",
    "JetBrainsMonoNLNerdFont-Italic.ttf",
    "JetBrainsMonoNLNerdFont-BoldItalic.ttf"
)

# Check both system and user font directories
$allInstalled = $true
foreach ($font in $requiredFonts) {
    if (!(Test-Path "$systemFontDir\$font") -and !(Test-Path "$userFontDir\$font")) {
        $allInstalled = $false
        break
    }
}

if (!$allInstalled) {
    Write-Host "🔤 Installing JetBrains Mono NL Nerd Font via Chocolatey..." -ForegroundColor Yellow
    choco install -y jetbrainsmono-nerd-font
    Write-Host "✅ Nerd Font installed" -ForegroundColor Green
} else {
    Write-Host "✅ Nerd Font already installed" -ForegroundColor Green
}

# --- Initialize zoxide for PowerShell ---
$profilePath = $PROFILE.CurrentUserAllHosts
if (!(Test-Path $profilePath)) {
    New-Item -Path $profilePath -ItemType File -Force | Out-Null
}

if (!(Select-String -Path $profilePath -Pattern "zoxide init" -Quiet -ErrorAction SilentlyContinue)) {
    Write-Host "⚙️ Adding zoxide init to PowerShell profile..." -ForegroundColor Yellow
    Add-Content -Path $profilePath -Value "`nInvoke-Expression (& { (zoxide init powershell | Out-String) })"
} else {
    Write-Host "✅ zoxide already initialized in profile" -ForegroundColor Green
}

# --- Clone Neovim config ---
$nvimConfigDir = "$env:LOCALAPPDATA\nvim"
if (Test-Path $nvimConfigDir) {
    Write-Host "📂 Neovim config already exists at $nvimConfigDir" -ForegroundColor Green
} else {
    Write-Host "📂 Cloning Neovim config..." -ForegroundColor Yellow
    git clone https://github.com/CardosoShlomo/nvim $nvimConfigDir
}

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "   1. Restart PowerShell/Windows Terminal" -ForegroundColor White
Write-Host "   2. Font should be auto-detected, but verify in:" -ForegroundColor White
Write-Host "      Windows Terminal → Settings (Ctrl+,) → Profile → Appearance → Font" -ForegroundColor White
Write-Host "   3. Run 'nvim' to start" -ForegroundColor White
