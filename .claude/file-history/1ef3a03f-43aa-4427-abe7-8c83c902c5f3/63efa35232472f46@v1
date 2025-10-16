{ pkgs, ... }:
{
  imports = [
    ./obs.nix
    ./steam.nix
    ./neovim.nix
  ];

  config = {
    home.packages = with pkgs; [
      mangohud
      protonup-qt
      lutris
      bottles
      heroic
    ];

    programs = {
      git = {
        enable = true;
        userName = "Borja Rojo Ilvento";
        userEmail = "borja.rojo@gmail.com";
      };

      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          theme = "alanpeabody";
          plugins = [
            "git"
            "fzf"
            "zoxide"
            "direnv"
          ];
        };
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
