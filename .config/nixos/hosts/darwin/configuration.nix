{ pkgs, inputs, ... }:
{

  users.users."I348749" = {
    home = "/Users/I348749";
    shell = pkgs.zsh;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "I348749"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "I348749" = import ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    fira-code-symbols
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    docker
    colima
  ];

  launchd.user.agents.colima = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      WorkingDirectory = "/Users/I348749";
      EnvironmentVariables = {
        PATH = "${pkgs.docker}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      "nvm"
      "edosrecki/tools/google-cloud-redis"
      "mole"
    ];
    taps = [ "nikitabobko/tap" ];
    casks = [
      "aerospace"
      "ghostty"
      # "anki"
      "google-chrome"
      "firefox"
      "intellij-idea"
      "karabiner-elements"
      "microsoft-teams"
      "phpstorm"
      "bruno"
      # "psst"
      "slack"
      "vscodium"
      "wireshark"
      "zed"
      "zoom"
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  system = {
    primaryUser = "I348749";
    stateVersion = 5;

    startup.chime = false;

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;
      universalaccess.reduceTransparency = true;
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSScrollAnimationEnabled = false;
        "com.apple.sound.beep.volume" = 0.000;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.keyboard.fnState" = true;
        "com.apple.swipescrolldirection" = false;
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
