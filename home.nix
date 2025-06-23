{
  lib,
  pkgs,
  dotfiles,
  ...
}:
{
  home.packages = with pkgs; [ stow ];

  home.file."dotfiles" = {
    source = dotfiles;
    recursive = true;
  };

  home.activation.stowDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    pushd $HOME/dotfiles
    ${pkgs.stow}/bin/stow -d stow -t ~ */
    popd
  '';
}
