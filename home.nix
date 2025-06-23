{
  pkgs,
  lib,
  dotfiles,
  ...
}:
let
  # dotfiles = pkgs.fetchFromGitHub {
  #   owner = "yourusername";
  #   repo = "dotfiles";
  #   rev = "main";
  #   sha256 = "...";
  # };
in
{
  home.packages = with pkgs; [ stow ];

  home.file."dotfiles" = {
    source = dotfiles;
    recursive = true;
  };

  home.activation.stowDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    pushd $HOME/dotfiles
    ${pkgs.stow}/bin/stow .
    popd
  '';
}
