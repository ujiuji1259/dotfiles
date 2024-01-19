## paths ###
typeset -gU PATH path
typeset -gU FPATH fpath

path=(
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

### for homebrew
### because sheldon is installed with homebrrew
if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  eval $($HOME/homebrew_m1/bin/brew shellenv)
else
  # x86_64
  eval $($HOME/homebrew/bin/brew shellenv)
fi

eval "$(sheldon source)"
