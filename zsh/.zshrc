# Created by newuser for 5.9
export PATH="$HOME/.local/bin:$PATH"
eval "$(oh-my-posh init zsh --config ~/dotfiles/oh-my-posh/catppuccin-pine.omp.toml)"

if [ -e /home/yanai/.nix-profile/etc/profile.d/nix.sh ]; then . /home/yanai/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
