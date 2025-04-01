# dotfiles
My Cross Platform setup for new MacOS/Windows Machines

## Windows Installation
In powershell run:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://raw.githubusercontent.com/CodedAbyss/dotfiles/refs/heads/main/install.sh | Invoke-Expression
```
## Unix Installation
In a terminal run:
```
source <(curl -s https://raw.githubusercontent.com/CodedAbyss/dotfiles/refs/heads/main/install.sh)
```
