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

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      # "aerospace"
      "alacritty"
      # "anki"
      "chromium"
      "docker"
      "firefox"
      "font-awesome-terminal-fonts"
      "font-fira-code"
      "font-fontawesome"
      "google-cloud-sdk"
      "graalvm-jdk@17"
      "insomnia"
      "intellij-idea-ce"
      "karabiner-elements"
      "keepassxc"
      "libreoffice"
      "microsoft-auto-update"
      "microsoft-teams"
      "phpstorm"
      # "psst"
      "slack"
      "temurin21"
      # "visual-studio-code"
      "vscodium"
      "wireshark"
      # "zed"
      "zoom"
    ];
  };
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  # bash is enabled by default

}
