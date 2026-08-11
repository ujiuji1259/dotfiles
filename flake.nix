# NOTE: 実機ごとの置き換えが必要な値
#   - CHANGEME-hostname: `scutil --get LocalHostName` の出力に置き換える
#   - CHANGEME-username: `whoami` の出力に置き換える (darwin/configuration.nix, home/home.nix にも同名の値がある)
{
  description = "ujiuji1259 dotfiles (nix-darwin + home-manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }:
    let
      username = "CHANGEME-username";
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations."CHANGEME-hostname" = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit username; };
        modules = [
          ./darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/home.nix;
          }
        ];
      };
    };
}
