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
    gpg.enable = true;
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
    tmux = {
      enable = true;
      extraConfig = builtins.readFile ../../../tmux/tmux.conf;
    };
    # neovim = {
    #   enable = true;
    #   withRuby = false;
    #   withPython3 = false;
    #   extraLuaConfig = builtins.readFile /home/ben/.config/nvim/init.lua.bck;
    # };
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
    slides
    ripgrep
    ripgrep-all
    fd
    gh
    neovim
    nnn
    ranger
    calcurse
    w3m
    doggo
    fastfetch
    killall
    pwgen
    curlie
    hexyl
    jq
    jless
    visidata
    inetutils
    pandoc
    imagemagick
    exiftool
    figlet
    entr
    zip
    unzip
    p7zip
    nmap
    (pass.withExtensions (exts: [ passExtensions.pass-otp ]))
    miniserve
    rlwrap

    # Monitoring
    htop
    bmon

    # Devtools
    emacs
    tree-sitter
    git
    jujutsu
    difftastic
    gnumake
    docker-compose
    universal-ctags

    # Langs

    (agda.withPackages (ps: [ ps.standard-library ]))
    ## Shell
    shellcheck
    bash-language-server
    ## Nix
    nixd
    nixfmt
    ## Python
    pyright
  ];
}
