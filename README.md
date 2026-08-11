# dotfiles

macOS (Apple Silicon) 向け。[nix-darwin](https://github.com/LnL7/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager) で宣言的に管理する。

## セットアップ

初回のみ、このリポジトリ内の以下のプレースホルダを実機の値に置き換える:

- `CHANGEME-hostname` (`flake.nix`) → `scutil --get LocalHostName` の出力
- `CHANGEME-username` (`flake.nix`, `darwin/configuration.nix`, `home/home.nix`) → `whoami` の出力

1. Nix をインストール (Determinate Systems installer, flakes がデフォルトで有効になる):
   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh
   ```
2. このリポジトリを clone し、`darwin-rebuild` を実行:
   ```sh
   git clone https://github.com/ujiuji1259/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   nix run nix-darwin -- switch --flake .#<hostname>
   ```
3. 2回目以降は `darwin-rebuild switch --flake ~/dotfiles#<hostname>` で反映する。

## 構成

- `flake.nix`: nix-darwin + home-manager のエントリポイント
- `darwin/configuration.nix`: システムレベルの設定。GUI アプリ・フォントは `homebrew` モジュール経由 (cask) で管理
- `home/home.nix`: ユーザーレベルの設定。CLI パッケージのインストールと `configs/*` のリンク配置
- `configs/*`: 各ツールの生設定ファイル (home-manager からリンクされる)

## 言語ランタイム

グローバルなバージョンマネージャ (mise 等) は使わない。プロジェクトごとに `direnv` (`nix-direnv` 有効) + `flake.nix` / `.envrc` でその都度 dev shell を用意する想定。
