{  pkgs, ... }:

{
  home.username = "I348749";
  home.homeDirectory = "/Users/I348749";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  services.syncthing.enable = true;

  # services.dunst = {
  #   enable = true;
  #   configFile = "~/.config/dunst/dunstrc";
  # };

  # services.autorandr = {
  #   enable = true;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /opt/homebrew/bin/pinentry-mac
    max-cache-ttl 60480000
    default-cache-ttl 60480000
  '';

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    yabai
    jq
    fzf
    ranger
    phpactor
    postgresql

    eza
    bat
    ripgrep
    fd
    curlie
    difftastic
    slides
    gh

    # nnn
    # ueberzugpp
    calcurse
    w3m
    k9s
    jless
    darwin.iproute2mac
    # doggo
    # newsboat
    # pulsemixer
    # fastfetch
    # killall
    # genpass
    #
    # # Monitoring
    btop
    gnupg
    # htop
    # bmon
    #
    # # Devtools
    neovim
    git
    difftastic
    #
    # # GUI
    # gnome.adwaita-icon-theme
    # feh
    # sxiv
    # unclutter-xfixes
    # calibre
    # xorg.xdpyinfo
    # xclip
    # tor-browser
    # anki
    # slack
    # grobi
    # dunst
    # libnotify
    # scrot
    # poppler_utils # For zathura preview
    # qbittorrent
    #
    # borgbackup
    # nmap
    # sshfs
    # playerctl
    # bleachbit
    # mpv
    zathura
    # yt-dlp
    (pass.withExtensions (exts: [
        passExtensions.pass-otp
    ]))
    # bottles
    # unzip
    # rofi-pass
    # neomutt
    # isync
    tmux
    # firefox
    # gcc
    # gnupg
    # pinentry-rofi
    # polkit
    # iw # i3blocks
    # pulseaudio # For pactl (i3blocks)
    # udiskie
    # smartmontools
    #
    # # Langs
    # (python3.withPackages(ps: [
    #     ps.python-lsp-server #ps.pyls-mypy ps.pyls-isort ps.pyls-black
    # ]))
    #
    # guile
    # guile-json
    ghc
    haskell-language-server
    graalvm-ce
    sbt
    coursier
    shellcheck
    nodePackages.bash-language-server
    bruno
    nixd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
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
