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

# --- Check for Nerd Font (4 variants only) ---
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$requiredFonts = @(
    "JetBrainsMonoNLNerdFont-Regular.ttf",
    "JetBrainsMonoNLNerdFont-Bold.ttf",
    "JetBrainsMonoNLNerdFont-Italic.ttf",
    "JetBrainsMonoNLNerdFont-BoldItalic.ttf"
)

$allInstalled = $true
foreach ($font in $requiredFonts) {
    if (!(Test-Path "$fontDir\$font")) {
        $allInstalled = $false
        break
    }
}

if (!$allInstalled) {
    Write-Host "🔤 Installing JetBrains Mono NL Nerd Font (4 variants)..." -ForegroundColor Yellow
    
    $tempDir = "$env:TEMP\nerd-fonts"
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
    
    # Download only the 4 essential variants
    $baseUrl = "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures"
    $fonts = @(
        "$baseUrl/Regular/JetBrainsMonoNLNerdFont-Regular.ttf",
        "$baseUrl/Bold/JetBrainsMonoNLNerdFont-Bold.ttf",
        "$baseUrl/Italic/JetBrainsMonoNLNerdFont-Italic.ttf",
        "$baseUrl/BoldItalic/JetBrainsMonoNLNerdFont-BoldItalic.ttf"
    )
    
    foreach ($fontUrl in $fonts) {
        $fontName = Split-Path $fontUrl -Leaf
        $fontPath = "$tempDir\$fontName"
        Write-Host "  Downloading $fontName..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $fontUrl -OutFile $fontPath
        
        # Install font
        $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
        $fonts.CopyHere($fontPath, 0x10)
    }
    
    Remove-Item -Recurse -Force $tempDir
    Write-Host "✅ Nerd Font installed" -ForegroundColor Green
} else {
    Write-Host "✅ All 4 Nerd Font variants already installed" -ForegroundColor Green
}

# --- Initialize zoxide for PowerShell ---
$profilePath = $PROFILE
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
Write-Host "   2. In Windows Terminal settings (Ctrl+,):" -ForegroundColor White
Write-Host "      - Go to your profile (Ubuntu/PowerShell)" -ForegroundColor White
Write-Host "      - Appearance → Font face → Select 'JetBrainsMonoNL Nerd Font Mono'" -ForegroundColor White
Write-Host "   3. Run 'nvim' to start" -ForegroundColor White
