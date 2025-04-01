echo \" <<'POWERSHELL_SCRIPT' >/dev/null # " | Out-Null
# ===== PowerShell Script Begin =====
function Link($path, $source) {
	if(!(Test-Path -Path $path)) {
		echo "Hard linking path. ($path)"
		$dir = Split-Path -Path $path -Parent
		if(!(Test-Path -Path $dir)) {
			New-Item -ItemType Directory -Path $dir | Out-Null
		}
		New-Item -ItemType HardLink -Path $dir -Name (Split-Path -Path $path -Leaf) -Value $source | Out-Null
	} else {
		echo "Link already exists. ($path)"
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

Link "$env:LOCALAPPDATA\nvim\init.lua" "$HOME\dotfiles\.config\nvim\init.lua"
Link "$HOME\.config\wezterm\wezterm.lua" "$HOME\dotfiles\.config\wezterm\wezterm.lua"
Link "$env:LOCALAPPDATA\clangd\config.yaml" "$HOME\dotfiles\.config\clangd\config-windows.yaml"
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
