# Install Script for Windows

## How to setup multiple instances of a Distro

1. Install the desired Distro: `wsl --install -d Ubuntu`
2. Set it up as you like
3. Shut all wsl down `wsl --shutdown`
4. Export the Settings and Distro by using: `wsl --export Ubuntu Ubuntu.tar`
5. Create as many copies of the Distro as you like, by: 
  - First create a new dir: `mkdir C:\WSLDistros\<YourDistroName>\`
  - Import the exported Distro: `wsl --import <YourDistroName> C:\WSLDistros\<YourDistroName>\ Ubuntu.tar`

To entere a wsl instance by default use `wsl --setdefault <Name of the Distro>`
Use `wsl -l -v` to see which distros are running.
Use `wsl -l -o` to see which distros are avaible for download and install.
Use `wsl --shutdown` to shutdown all instances.
