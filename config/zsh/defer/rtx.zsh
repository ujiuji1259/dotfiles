# for rtx
if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  export RTX_DATA_DIR="$XDG_DATA_HOME/rtx_arm"
  export RTX_STATE_DIR="$XDG_STATE_HOME/rtx_arm"
  export RTX_CONFIG_DIR="$XDG_CONFIG_HOME/rtx_arm"
  export RTX_CACHE_DIR="$XDG_CACHE_HOME/rtx_arm"
else
  # x86_64
  export RTX_DATA_DIR="$XDG_DATA_HOME/rtx_x64"
  export RTX_STATE_DIR="$XDG_STATE_HOME/rtx_x64"
  export RTX_CONFIG_DIR="$XDG_CONFIG_HOME/rtx_x64"
  export RTX_CACHE_DIR="$XDG_CACHE_HOME/rtx_x64"
fi
eval "$(rtx activate zsh)"

