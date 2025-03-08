#Requires -RunAsAdministrator

function linkAppdata($folder) {
	$localConfig = Join-Path $env:LOCALAPPDATA $folder
	$dotfiles = Join-Path $HOME "dotfiles\.config"
	$dotfilesConfig = Join-Path $dotfiles $folder
	New-Item -Path $localConfig -ItemType SymbolicLink -Value $dotfilesConfig
}

function linkConfig($folder) {
	$localConfig = Join-Path $HOME ".config"
	$localConfig = Join-Path $localConfig $folder
	$dotfilesConfig = Join-Path $HOME "dotfiles\.config"
	$dotfilesConfig = Join-Path $dotfilesConfig $folder
	New-Item -Path $localConfig -ItemType SymbolicLink -Value $dotfilesConfig
}

cd $HOME
if (!$(Get-Command scoop -ErrorAction SilentlyContinue)) {
	echo Installing scoop.sh as package manager...
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	
	echo Installing utilities...
	scoop install git
	scoop install zig
	scoop install neovim
	scoop bucket add extras
	scoop install wezterm
	
	git clone https://github.com/CodedAbyss/dotfiles.git
}

echo "symlink neovim"
linkAppdata "nvim"
echo "symlink wezterm"
linkConfig "wezterm"
pause
