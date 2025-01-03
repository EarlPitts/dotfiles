{ pkgs, ... }:

{
  imports = [ ../shared/home.nix ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  services = {
    # gpg-agent.pinentryPackage = pkgs.pinentry-rofi;

    # dunst = {
    #   enable = true;
    #   configFile = "~/.config/dunst/dunstrc";
    # };
  };

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /home/ben/.nix-profile/bin/pinentry-rofi
    max-cache-ttl 60480000
    default-cache-ttl 60480000
  '';

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
    pinentry-rofi
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
    # bottles
    (mpv.override { scripts = [ mpvScripts.mpris ]; })

    polkit

    # Langs

    ## Python
    (python3.withPackages (ps: [ ps.matplotlib ps.numpy ]))
    ## Guile
    guile
    guile-json
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
