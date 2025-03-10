{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./dae
    ./firefox
    ./zsh
    ./nil
    ./fonts
    ./stylix
    ./fcitx5-rime
    ./hyprland
    ./driver
  ];

  # The basic system configuration.

  # BootLoader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the wshowkeys program
  programs.wshowkeys.enable = true;

  # Enable networking
  networking = {
    hostName = "NixOS";
  };

  # Set up the time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure the system locale.
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

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable the X11 windowing system and configure the X11 keyboard layout.
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      clickMethod = "clickfinger";
      naturalScrolling = true;
      tapping = true;
    };
  };
  environment.systemPackages = with pkgs; [
    libinput
    # wayland 事件查看器
    wev
  ];

  # Enable the power-settings 电源计划
  services.power-profiles-daemon = {
    enable = true;
    package = pkgs.power-profiles-daemon;
  };

  # Define a user account.
  users.users.elokelears = {
    isNormalUser = true;
    description = "elokelears";
    home = "/home/elokelears";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the feature flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # State version
  system.stateVersion = "24.11";
}
