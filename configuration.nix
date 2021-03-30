{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # System version:
  system.stateVersion = "20.09";

  # Bootloader:
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Collect nix garbage and optimize daily:
  nix.gc.automatic = true;
  nix.optimise.automatic = true;
  
  # Auto-upgrade packages:
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = https://nixos.org/channels/nixos-unstable;
  };
  
  # Locale:
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Timezone:
  time.timeZone = "America/Chicago";
  
  # Networking:
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    hostName = "nixos";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };
  
  # Users:
  users.extraUsers.madelyn = {
    uid = 1000;
    home = "/home/madelyn";
    description = "Madelyn Zamenski";
    isNormalUser = true;
    extraGroups = [ "wheel" "storage" "power" "audio" "video" "networkmanager" ];
  };
  
  # Audio:
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  
  # OpenGL:
  hardware.opengl.driSupport32Bit = true;

  # X server:
  services.xserver = {
    enable = true;
    libinput.enable = true;
    videoDrivers = [ "radeon" ];
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  # Enable Unfree:
  nixpkgs.config.allowUnfree = true;

  # Gnupg
  programs.gnupg.agent.enable = true;
  
  # Packages
  environment.systemPackages = with pkgs; [
    # Fonts:
    noto-fonts-cjk
    # Console:
    bash
    file
    lsof
    wget
    curl
    whois
    which
    unzip
    unrar
    xclip
    rsync
    gnupg
    man-pages
    neofetch
    xorg.xkill
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    # Drivers:
    epson-escpr
    # Development:
    zeal
    maven
    gradle
    groovy
    kdevelop
    netbeans
    smartgithg
    jetbrains.pycharm-community
    # Internet:
    tdesktop
    qbittorrent
    konversation
    google-chrome
    # Games:
    lutris
    steam
    # Graphics:
    krita
    gwenview
    spectacle
    kcolorchooser
    # Office:
    okular
    qownnotes
    libreoffice
    thunderbird
    # Education:
    anki
    tagainijisho
    # Multimedia:
    vlc
    elisa
    obs-studio
    # Accesories:
    kcalc
    latte-dock
    # System:
    kgpg
    konsole
    ksysguard
    bitwarden
    ksystemlog
    # Themes:
    arc-theme
    arc-kde-theme
    # Security:
    clamav
    firejail
    bleachbit
    chkrootkit
  ];  
}
