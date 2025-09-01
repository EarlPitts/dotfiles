{ pkgs, ... }:

{
  imports = [ ../shared/home.nix ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
      maxCacheTtl = 60480000;
      defaultCacheTtl = 60480000;
    };
    mpris-proxy.enable = true;

    # dunst = {
    #   enable = true;
    #   configFile = "~/.config/dunst/dunstrc";
    # };
  };

  home.packages = with pkgs; [

    # CLI tools
    acpi
    newsboat
    pulsemixer
    lsof
    neomutt
    isync
    smartmontools
    borgbackup
    yt-dlp
    sshfs
    iw # i3blocks
    pulseaudio # For pactl (i3blocks)
    udiskie
    playerctl

    # Devtools
    gcc

    # GUI
    rofi
    rofi-pass
    rofi-calc
    ueberzugpp
    adwaita-icon-theme
    feh
    sxiv
    unclutter-xfixes
    calibre
    xorg.xdpyinfo
    xclip
    anki
    slack
    grobi
    dunst
    libnotify
    scrot
    poppler_utils # For zathura preview
    qbittorrent
    telegram-desktop
    darktable
    spotify
    discord
    zathura
    firefox
    tor-browser
    wireshark
    bottles
    (mpv.override { scripts = [ mpvScripts.mpris ]; })

    polkit

    # Langs

    ## Python
    (python3.withPackages (ps: [
      ps.matplotlib
      ps.numpy
    ]))
    ## Guile
    guile
    guile-json
    ## Racket
    racket-minimal
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ben/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
  #   # EDITOR = "emacs";
  # };
}
