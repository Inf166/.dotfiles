# Upgrade exisiting packages with winget
winget upgrade --all
# Install packages with winget
$packages = @(
    "Git.Git",
    "Docker.DockerDesktop"
    "Microsoft.PowerToys",
    "JackieLiu.NotepadsApp",
    "ModernFlyouts.ModernFlyouts",
    "QL-Win.QuickLook",
    "lencx.ChatGPT",
    "DeepL.DeepL",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Microsoft.Edge",
    "qutebrowser.qutebrowser",
    "Notepad++.Notepad++",
    "JetBrains.Toolbox",
    "JetBrains.PHPStorm",
    "JetBrains.WebStorm",
    "JetBrains.IntelliJIDEA.Ultimate",
    "Microsoft.VisualStudioCode",
    "Canonical.Ubuntu.2204",
    "Spotify.Spotify",
    "Figma.Figma",
    "Microsoft.WindowsTerminal",
    "Starship.Starship",
    "Microsoft.Powershell",
    "chrisant996.Clink"
    "DEVCOM.JetBrainsMonoNerdFont",
    "DominikReichl.KeePass",
    "Zoom.Zoom"
)

foreach ($package in $packages) {
    Write-Host "Installing $($package)..."
    if (!(winget install --id=$package -e)) {
        Write-Warning "Failed to install $($package)."
    }
}

# Download and Install MJML
$url = 'https://github.com/mjmlio/mjml-app/releases/download/v3.0.4/mjml-app-3.0.4-win.exe'
$output = "$env:TEMP\mjml-app-3.0.4-win.exe"

Write-Host "Downloading MJML installer from $url..."
try {
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing -ErrorAction Stop -ProgressPreference SilentlyContinue
} catch {
    Write-Error "Failed to download MJML installer: $_"
    exit 1
}

Write-Host "Installing MJML..."
try {
    Start-Process -FilePath $output -ArgumentList '/S' -Wait
} catch {
    Write-Error "Failed to install MJML: $_"
    exit 1
}

Write-Host "Installation complete."


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

# Set default WSL version to 2
Write-Host "Setting default WSL version to 2..."
wsl --set-default-version 2

# Download and install Ubuntu 22.04 appx package
$distroName = "Ubuntu-22.04"
$downloadUrl = "https://aka.ms/wslubuntu2204"
$tempFile = "$env:TEMP\Ubuntu-22.04.appx"

Write-Host "Downloading Ubuntu 22.04 appx package from $downloadUrl..."
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile -UseBasicParsing -ErrorAction Stop -ProgressPreference SilentlyContinue
} catch {
    Write-Error "Failed to download Ubuntu 22.04 appx package: $_"
    exit 1
}

Write-Host "Installing Ubuntu 22.04 appx package..."
try {
    Add-AppxPackage -Path $tempFile -ErrorAction Stop
} catch {
    Write-Error "Failed to install Ubuntu 22.04 appx package: $_"
    exit 1
}

Write-Host "Installation complete. To launch Ubuntu 22.04, run the command 'wsl --distribution $distroName'."

# sudo apt update && sudo apt full-upgrade

# Enable WSLg (requires newer versions of window 10 or 11)
# sudo nano /etc/wsl.conf
# [boot]
# systemd=true

# Install GUI for WSL2
# sudo apt update && sudo apt install x11-apps
# xeyes &
# xcalc // Run calculator GUI

# Install Docker on WSL2
# sudo apt install --no-install-recommends apt-transport-https ca-certificates curl gnupg2
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test"
# sudo apt update
# sudo apt install docker-ce docker-ce-cli containerd.io
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

# Choco Install of ddev in wsl (requires wsl to be setup and be run in the admin Powershell)
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
# iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ddev/ddev/master/scripts/install_ddev_wsl2_docker_inside.ps1'))

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ddev/ddev/master/scripts/install_ddev_wsl2_docker_desktop.ps1'))
