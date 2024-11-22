{ config, pkgs, ... }:

{
  home.username = "freep";
  home.homeDirectory = "/home/freep";
  
  home.packages = with pkgs; [
    # Desktop Environment (Needed for i3 config)
    scrot
    flameshot
    feh
    numlockx
    pavucontrol
    kitty
    autorandr
    light
    xss-lock
  
    # Networking
    nmap
    dnsutils
    wget
    aria2 # Dowloader

    # Archives
    zip
    unzip
    xz
    p7zip
    unrar
    gnutar

    # Utilities
    ripgrep
    jq
    yq-go
    eza # Modern ls
    tree
    gawk
    gnused
    file
    which
    bat
    openssl

    # Productivity
    glow
    zola

    # Tools
    keepass

    # Misc
    mpv
    vlc
  ];

  programs.git = {
    enable = true;
    userName = "Enzo Petit";
    userEmail = "contact@epetit.fr";
    aliases = {
      logtree = "log --graph --abrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
    };
    extraConfig.init.defaultBranch = "main";
  };
  programs = {
    firefox.enable = true;
    fzf.enable = true;
  };

  #Let HomeManager manage itself
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
