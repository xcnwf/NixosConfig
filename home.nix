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
    tree
    gawk
    gnused
    file
    which
    bat
    openssl

    # File Manager
    nnn
    xfce.thunar
    ranger

    # Productivity
    glow # Markdown terminal preview
    zola
    typst
    pandoc

    # Password Manager
    keepass

    # Editor
    helix

    # Misc
    mpv
    vlc


    # Hacking tools
    metasploit
    nmap
    sqlmap
    burpsuite
    psudohash
    thc-hydra
    bloodhound
    arsenal
  ];

  home.shellAliases = {
    gs = "git status";
  };

  programs.zoxide.enable = true;
  programs.eza.enable = true; # Modern ls

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
    starship.enable = true;
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "cp"];
      };
    };
  };

  services.dunst.enable = true;

  #Let HomeManager manage itself
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
