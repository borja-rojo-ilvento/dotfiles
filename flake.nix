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
    {
      nixosModules.default = import ./home.nix {
        pkgs = nixpkgs;
        lib = nixpkgs.lib;
        dotfiles = self;
      };
    };
}
