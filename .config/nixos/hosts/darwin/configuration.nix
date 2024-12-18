# hosts/YourHostName/default.nix
{ pkgs, inputs, ... }: {

  system.stateVersion = 5;

  users.users."I348749" = {
    home = "/Users/I348749";
    shell = pkgs.zsh;
  };

  services.nix-daemon.enable = true;

  services.skhd.enable = true;
  services.yabai.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "I348749" = import ./home.nix; };
  };

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    brews = [ "pinentry-mac" "nvm" ];
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
      "vscodium"
      "wireshark"
      # "zed"
      "zoom"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

}
