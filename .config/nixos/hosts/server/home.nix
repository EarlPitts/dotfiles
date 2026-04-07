{ pkgs, ... }:

{
  imports = [ ];

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

    polkit
  ];

}
