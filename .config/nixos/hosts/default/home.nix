{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "obabo";
  home.homeDirectory = "/home/obabo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  #services.gpg-agent.pinentryPackage = pkgs.pinentry-rofi;

  services.syncthing.enable = true;

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /home/obabo/.nix-profile/bin/pinentry-rofi
    max-cache-ttl 60480000
    default-cache-ttl 60480000
  '';

  # services.dunst = {
  #   enable = true;
  #   configFile = "~/.config/dunst/dunstrc";
  # };

  # services.autorandr = {
  #   enable = true;
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # CLI tools
    tree
    eza
    bat
    slides
    gh
    ripgrep
    fd
    fzf
    rofi
    pinentry-rofi
    rofi-pass
    rofi-calc
    nnn
    ranger
    ueberzugpp
    acpi
    calcurse
    w3m
    doggo
    newsboat
    pulsemixer
    fastfetch
    killall
    genpass
    curlie
    jq
    visidata
    universal-ctags
    pandoc
    imagemagick
    lsof
    exiftool
    figlet

    # Monitoring
    btop
    htop
    bmon

    # Devtools
    neovim
    git
    difftastic
    gnumake

    # GUI
    adwaita-icon-theme
    feh
    sxiv
    unclutter-xfixes
    calibre
    koreader
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

    docker-compose
    borgbackup
    nmap
    sshfs
    playerctl
    bleachbit
    (mpv.override {scripts = [ mpvScripts.mpris ];})
    zathura
    yt-dlp
    (pass.withExtensions (exts: [
        passExtensions.pass-otp
    ]))
    bottles
    unzip
    neomutt
    isync
    tmux
    firefox
    gcc
    gnupg
    polkit
    iw # i3blocks
    pulseaudio # For pactl (i3blocks)
    udiskie
    smartmontools
    ncspot

    # Langs
    (python3.withPackages(ps: [
        ps.python-lsp-server #ps.pyls-mypy ps.pyls-isort ps.pyls-black
        ps.matplotlib
        ps.numpy
    ]))

    guile
    guile-json
    sbt
    coursier
    graalvm-ce
    ghc
    cabal-install
    haskell-language-server
    shellcheck
    nodePackages.bash-language-server
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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
  #  /etc/profiles/per-user/obabo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
