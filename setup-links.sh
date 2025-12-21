# !/bin/bash -e

ln -snfv "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -snfv "$(pwd)/configs/sheldon/.sheldon.toml" "$HOME/.sheldon.toml"

echo "Success"