{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Basic networking
  networking.networkmanager.enable = true;

  # Locale and timezone
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Audio system
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Shell configuration
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Printing
  services.printing.enable = true;

  # Nixpkgs configuration
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = [
      "qtwebengine-5.15.19"
    ];
  };

  # System version
  system.stateVersion = "24.05";

  services = {
    xserver.enable = true; # Turn on the GUI (not X11 itself)
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasmax11"; # Use X11 session
    };
    desktopManager.plasma6.enable = true;
  };

  # Security services for desktop
  security.pam.services = {
    sddm.enableKwallet = true;
    sddm.gnupg.enable = true;
    login.enableKwallet = true;
    passwd.enableKwallet = true;
  };

  # XDG portal configuration for desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk # Better X11 support
    ];
    config.common.default = "kde";
  };

  # Force applications to use X11
  environment.variables = {
    GDK_BACKEND = "x11";
    QT_QPA_PLATFORM = "xcb";
    NIXOS_OZONE_WL = "0"; # Force Electron apps to X11
  };
}
