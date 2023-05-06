# Install packages with winget
$packages = @(
    "Git.Git",
    "Microsoft.PowerToys",
    "JackieLiu.NotepadsApp",
    "ModernFlyouts.ModernFlyouts",
    "QL-Win.QuickLook",
    "lencx.ChatGPT",
    "DeepL.DeepL",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Notepad++.Notepad++",
    "JetBrains.Toolbox",
    "JetBrains.PHPStorm",
    "JetBrains.WebStorm",
    "JetBrains.IntelliJIDEA.Ultimate",
    "Microsoft.VisualStudioCode",
    "Spotify.Spotify",
    "Figma.Figma",
    "Microsoft.WindowsTerminal",
    "Starship.Starship",
    "Microsoft.Powershell",
    "chrisant996.Clink"
    "DEVCOM.JetBrainsMonoNerdFont",
    "DominikReichl.KeePass",
    "Zoom.Zoom",
    "qutebrowser.qutebrowser"
)

foreach ($package in $packages) {
    Write-Host "Installing $($package)..."
    if (!(winget install --id=$package -e)) {
        Write-Warning "Failed to install $($package)."
    }
}

# Download and install MJML
# https://github.com/mjmlio/mjml-app/releases/download/v3.0.4/mjml-app-3.0.4-win.exe

# Download and install Starship for cmd
$starshipLuaPath = "$env:LOCALAPPDATA\clink\starship.lua"
$starshipInitCmd = (io.popen('starship init cmd'):read("*a")())

try {
    if (!(Test-Path $starshipLuaPath)) {
        New-Item -Path $starshipLuaPath -ItemType File -Force
    }

    Set-Content -Path $starshipLuaPath -Value $starshipInitCmd
} catch {
    Write-Warning "Failed to download and install Starship for cmd."
} finally {
}


# WSL install
# wsl --list --online
# wsl --install -d Ubuntu-22.04
# wsl --set-default-version 2
# wsl --set-default Ubuntu-22.04
# wsl --set-version Ubuntu-22.04 2
# sudo apt update && sudo apt full-upgrade
# sudo nano /etc/wsl.conf
# [boot]
# systemd=true

# Install GUI for WSL2
# sudo apt update && sudo apt install x11-apps
# xeyes &
# xcalc // Run calculator gui

# Install Docker on WSL2
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
# sudo usermod -aG docker $USER
# sudo apt-get update && sudo apt-get install docker-compose-plugin
# docker --version
# docker compose version
# sudo update-alternatives --config iptables
# Add this to the ~/.profile
# if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
#     if service docker status 2>&1 | grep -q "is not running"; then
#         wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
#             --exec /usr/sbin/service docker start > /dev/null 2>&1
#     fi
# fi
