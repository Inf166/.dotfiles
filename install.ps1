# Install packages with winget
$packages = @(
    "Microsoft.WindowsTerminal",
    "Git.Git",
    "Microsoft.PowerToys",
    "JackieLiu.NotepadsApp",
    "Docker.DockerDesktop",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Notepad++.Notepad++",
    "JetBrains.Toolbox",
    "JetBrains.PHPStorm",
    "JetBrains.WebStorm",
    "JetBrains.IntelliJIDEA.Ultimate",
    "Microsoft.VisualStudioCode",
    "Spotify.Spotify",
    "Starship.Starship",
    "Figma.Figma",
    "Microsoft.Powershell",
    "chrisant996.Clink"
    "DominikReichl.KeePass",
    "qutebrowser.qutebrowser"
)

foreach ($package in $packages) {
    Write-Host "Installing $($package)..."
    if (!(winget install --id=$package -e)) {
        Write-Warning "Failed to install $($package)."
    }
}

# Download and install Jetbrains Mono Nerd Font
$url = 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip'
$tempFile = "$env:TEMP\JetBrainsMono.zip"
$extractionPath = "$env:TEMP\JetBrainsMono"

try {
    Invoke-WebRequest -Uri $url -OutFile $tempFile
    Expand-Archive -Path $tempFile -DestinationPath $extractionPath -Force

    foreach ($fontFile in Get-ChildItem "$extractionPath\*" -Include '*.ttf', '*.otf' -Recurse) {
        Write-Host "Installing $($fontFile.Name)..."
        $fontPath = Join-Path ([Environment]::GetFolderPath('Fonts')) $fontFile.Name
        Copy-Item -Path $fontFile.FullName -Destination $fontPath -Force
    }
} catch {
    Write-Warning "Failed to download and install Jetbrains Mono Nerd Font."
} finally {
    Remove-Item $tempFile -Force
    Remove-Item $extractionPath -Recurse -Force
}

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
