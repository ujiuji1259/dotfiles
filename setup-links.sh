# !/bin/bash -e

ln -snfv "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -snfv "$(pwd)/configs/sheldon/.sheldon.toml" "$HOME/.sheldon.toml"

if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
fi
ln -snfv "$(pwd)/configs/nvim" "$HOME/.config"
ln -snfv "$(pwd)/configs/wezterm" "$HOME/.config"
ln -snfv "$(pwd)/configs/starship/starship.toml" "$HOME/.config"
ln -snfv "$(pwd)/configs/tmux" "$HOME/.config"
ln -snfv "$(pwd)/configs/zsh-abbr" "$HOME/.config"

echo "Success"
