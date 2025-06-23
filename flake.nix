{
  description = "Expose a home-manager module with injects these dotfiles into the dotfiles/ directory, and runs `stow .` to copy them in.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      nixosModules = forAllSystems (system: {
        default = { pkgs, lib, ... }: import ./home.nix {
          inherit pkgs lib;
          dotfiles = self;
        };
      });
    };
}
