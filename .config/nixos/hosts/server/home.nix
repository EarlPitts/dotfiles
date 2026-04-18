{ pkgs, ... }:

{
  imports = [ ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.stateVersion = "23.11"; # Please read the comment before changing.

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
    neovim = {
      enable = true;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses;
      maxCacheTtl = 60480000;
      defaultCacheTtl = 60480000;
    };
  };

  home.packages = with pkgs; [

    # CLI tools
    acpi
    lsof
    neomutt
    isync
    smartmontools
    borgbackup
    sshfs
    udiskie
    tree
    ripgrep
    eza
    bat
    fzf
    ranger
    killall
    jq
    tmux
    git
    direnv
    tree-sitter
    gcc

    polkit
  ];

}
