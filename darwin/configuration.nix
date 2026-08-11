{ pkgs, username, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 5;
  system.primaryUser = username;

  users.users.${username}.home = "/Users/${username}";

  # GUI アプリ・フォントは nix-darwin の homebrew モジュール経由で管理する
  # (純 Nix でのビルド/署名が面倒なため brew に任せる)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "none";
    };
    casks = [
      "wezterm"
      "font-hackgen"
      "font-hackgen-nerd"
    ];
  };
}
