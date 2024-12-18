{ pkgs, ... }:

{
  imports = [ ../shared/home.nix ];

  home.username = "I348749";
  home.homeDirectory = "/Users/I348749";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /opt/homebrew/bin/pinentry-mac
    max-cache-ttl 60480000
    default-cache-ttl 60480000
  '';

  home.packages = with pkgs; [
    k9s
    iproute2mac
    postgresql
    zathura
    bruno

    # Langs
    nodejs
    phpactor
  ];
}
