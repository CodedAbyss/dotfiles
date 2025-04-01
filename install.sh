echo \" <<'POWERSHELL_SCRIPT' >/dev/null # " | Out-Null
# ===== PowerShell Script Begin =====
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  {
	Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	exit
}

function Link($path, $source) {
	if(!(Test-Path -Path $path)) {
		echo "Symlinking $path"
		New-Item -Path $path -ItemType SymbolicLink -Value $source
	} else {
		echo "$path already exists."
	}
}

function InstallOrUpdate($cmd, $package, $bucket) {
	if (!$(Get-Command $cmd -ErrorAction SilentlyContinue)) {
		echo "Installing $package..."
		if($bucket) {
			scoop bucket add $bucket
		}
		scoop install $package
	} else {
		echo "Updating $package..."
		scoop update $package
	}
}

cd $HOME
if (!$(Get-Command scoop -ErrorAction SilentlyContinue)) {
	echo Installing scoop.sh as package manager...
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

InstallOrUpdate "git" "git"
InstallOrUpdate "zig" "zig"
InstallOrUpdate "nvim" "neovim"
InstallOrUpdate "wezterm" "wezterm" "extras"

if(!(Test-Path -Path "$HOME\dotfiles")) {
	git clone https://github.com/CodedAbyss/dotfiles.git
}

Link "$env:LOCALAPPDATA\nvim" "$HOME\dotfiles\.config\nvim"
Link "$HOME\.config\wezterm" "$HOME\dotfiles\.config\nvim"
Link "$env:LOCALAPPDATA\clangd" "$HOME\dotfiles\.config\clangd"
Link "$HOME\dotfiles\.config\clangd\config.yaml" "$HOME\dotfiles\.config\clangd\config-windows.yaml"
pause
exit
<#
POWERSHELL_SCRIPT
# ====== PowerShell Script End ======

# ===== Bash Script Begin =====

# check OS
# brew install git
# brew install zig
# brew install neovim
# brew install wezterm

# git clone https://github.com/CodedAbyss/dotfiles.git

# ====== Bash Script End ======
exit
#>
