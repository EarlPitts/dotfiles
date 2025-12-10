{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    gpg = {
      enable = true;
    };
  };

  services.syncthing.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    # CLI tools
    tree
    eza
    bat
    slides
    gh
    ripgrep
    ripgrep-all
    fd
    fzf
    nnn
    ranger
    calcurse
    w3m
    doggo
    fastfetch
    killall
    pwgen
    curlie
    jq
    jless
    visidata
    inetutils
    pandoc
    imagemagick
    exiftool
    figlet
    entr
    tmux
    unzip
    p7zip
    nmap
    (pass.withExtensions (exts: [ passExtensions.pass-otp ]))
    miniserve
    rlwrap

    # Monitoring
    btop
    htop
    bmon

    # Devtools
    neovim
    emacs
    git
    jujutsu
    difftastic
    gnumake
    docker-compose
    universal-ctags

    # Langs

    ## Scala
    sbt
    coursier
    graalvmPackages.graalvm-ce
    ## Haskell
    (ghc.withPackages (hp: with hp; [ zlib ]))
    stack
    cabal-install
    haskell-language-server
    (agda.withPackages (ps: [ ps.standard-library ]))
    ## Shell
    shellcheck
    nodePackages.bash-language-server
    ## Nix
    nixd
    nixfmt-rfc-style
    ## Lua
    lua-language-server
    ## Python
    pyright
  ];
}
