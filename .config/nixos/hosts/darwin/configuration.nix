{ pkgs, inputs, ... }: {

  users.users."I348749" = {
    home = "/Users/I348749";
    shell = pkgs.zsh;
  };

  services.nix-daemon.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "I348749" = import ./home.nix; };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    fira-code-symbols
    font-awesome
  ];

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    brews = [ "nvm" ];
    taps = [ "nikitabobko/tap" ];
    casks = [
      "aerospace"
      "ghostty"
      # "anki"
      "google-chrome"
      "docker"
      "firefox"
      "insomnia"
      "intellij-idea-ce"
      "karabiner-elements"
      "microsoft-teams"
      "phpstorm"
      "bruno"
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

  system = {
    stateVersion = 5;

    startup.chime = false;

    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.sound.beep.volume" = 0.000;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.keyboard.fnState" = true;
      };

      dock = {
        autohide = true;
        tilesize = 40;
        show-recents = false;
        launchanim = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
      };

      screencapture.location = "~/Pictures/";

      loginwindow.LoginwindowText = "Hi, I'm a computer";

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerTapGesture = 0;
      };
    };
  };

}
