# !/bin/bash -e

ln -snfv "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -snfv "$(pwd)/configs/sheldon/.sheldon.toml" "$HOME/.sheldon.toml"
ln -snfv "$(pwd)/configs/tmux/.tmux.conf" "$HOME/.tmux.conf"

if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
fi
ln -snfv "$(pwd)/configs/nvim" "$HOME/.config"

echo "Success"