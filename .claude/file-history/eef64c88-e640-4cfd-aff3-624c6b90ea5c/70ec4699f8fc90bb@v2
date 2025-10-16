{
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  home.packages = with pkgs; [
    # stremio # Takes WAY too long to build.
    nix-search-cli
    firefox
    clang
    gnumake
    cargo
    rustc
    rustfmt
    go
    nodejs
    wget
    git
    code-cursor
    zoom-us
    xwayland
    zoxide
    ripgrep
    flameshot
    fzf
    ledger-live-desktop
    ledger-udev-rules
    ghostty
    kdePackages.kscreen
    home-manager
    nmap
    arp-scan
    google-chrome
    obsidian
    jdk
    devbox
    stow
    pkg-config
    openssl
    nix-direnv
    oh-my-zsh
    tree
    ani-cli
    claude-code
    godot
    bat
    pandoc
    texliveTeTeX
    texlivePackages.sectsty
    libnotify
    gh
    gemini-cli
    eza
    audacity
    claude-code
    freerdp
    remmina
    mesa-demos
    jq
  ];

  home.stateVersion = "24.11";
}
