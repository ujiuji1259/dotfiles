{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    tmux
    neovim
    sheldon
    starship
    ghq
    fzf
    ripgrep
    lazygit
    tree-sitter
    deno
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # setup-links.sh の手書き ln -snfv を置き換え
  home.file.".zshrc".source = ../.zshrc;
  home.file.".sheldon.toml".source = ../configs/sheldon/.sheldon.toml;

  xdg.configFile = {
    "nvim".source = ../configs/nvim;
    "wezterm".source = ../configs/wezterm;
    "starship.toml".source = ../configs/starship/starship.toml;
    "tmux".source = ../configs/tmux;
    "zsh-abbr".source = ../configs/zsh-abbr;
  };
}
