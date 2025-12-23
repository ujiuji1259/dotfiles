typeset -gU PATH path
typeset -gU FPATH fpath

path=(
    '/opt/homebrew/bin'(N-/)
    '/usr/local/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/local/sbin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
)

path=(
    "$HOME/.local/bin"(N-/)
    "$path[@]"
)

# for sheldon
export SHELDON_CONFIG_FILE=$HOME/.sheldon.toml
eval "$(sheldon source)"

# for starship
export STARSHIP_CONFIG="$ZDOTDIR/configs/starship/starship.toml"

# for mise
eval "$(mise activate zsh)"

