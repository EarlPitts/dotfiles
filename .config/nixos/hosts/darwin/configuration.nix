# hosts/YourHostName/default.nix
{ pkgs, inputs, ... }:
{

  users.users."I348749" = {
    home = "/Users/I348749";
    shell = pkgs.zsh;
  };

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;

  services.skhd.enable = true;
  services.yabai.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "I348749" = import ./home.nix;
    };
  };
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  # bash is enabled by default

}
