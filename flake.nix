{
  description = "Expose a home-manager module with injects these dotfiles into the dotfiles/ directory, and runs `stow .` to copy them in.";

  inputs = { };
  outputs =
    { self }:
    {
      nixosModules.default = import ./home.nix { dotfiles = self; };
    };
}
