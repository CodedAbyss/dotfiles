cd ~
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
	
	$localConfiguration = Join-Path $env:LOCALAPPDATA "nvim"
}
