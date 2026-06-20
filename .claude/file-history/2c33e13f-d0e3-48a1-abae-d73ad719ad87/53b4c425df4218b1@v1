{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    steam-run
    (makeDesktopItem {
      name = "steam-fhs";
      exec = "${steam-run}/bin/steam-run ${steam}/bin/steam";
      icon = "steam";
      desktopName = "Steam (FHS)";
      categories = [ "Game" ];
    })
  ];
}
