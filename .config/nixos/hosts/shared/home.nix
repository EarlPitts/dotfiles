{ pkgs, ... }:

{
  home.sessionVariables = { EDITOR = "nvim"; };

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  services.syncthing.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    # CLI tools
    tree
    eza
    bat
    slides
    gh
    ripgrep
    fd
    fzf
    nnn
    ranger
    calcurse
    w3m
    doggo
    fastfetch
    killall
    genpass
    curlie
    jq
    jless
    visidata
    pandoc
    imagemagick
    exiftool
    figlet
    entr
    tmux
    unzip
    nmap
    gnupg
    (pass.withExtensions (exts: [ passExtensions.pass-otp ]))

    # Monitoring
    btop
    htop
    bmon

    # Devtools
    neovim
    git
    difftastic
    gnumake
    docker-compose
    universal-ctags

    # Langs

    ## Scala
    sbt
    coursier
    graalvm-ce
    ## Haskell
    ghc
    cabal-install
    haskell-language-server
    ## Shell
    shellcheck
    nodePackages.bash-language-server
    ## Nix
    nixd
    nixfmt
  ];
}
