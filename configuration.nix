# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
  boot.kernelModules = ["iwlwifi"]

  boot.initrd.luks.devices."luks-a26d67d5-192f-4d1a-ad29-0c807690f094".device = "/dev/disk/by-uuid/a26d67d5-192f-4d1a-ad29-0c807690f094";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
    model = "pc105";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    #displayManager.lightdm.greeter = false;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi
        i3status-rust
        i3lock
      ];
    };
  };
  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true;
      user = "freep";
    };
  };
  
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freep = {
    isNormalUser = true;
    description = "freep";
    extraGroups = [ "networkmanager" "wheel" "video"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    python3
    # newpckg anchor for quicksearch
  ];
  services.blueman.enable = true;
  programs.zsh.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["FiraCode" "IBMPlexMono"];})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
    allowedUDPPorts = [ ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
