{
  config,
  pkgs,
  inputs,
  pkgs-stable,
  ...
}:
let
  user = config.system.primaryUser;
in
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
    extraSpecialArgs = { inherit inputs pkgs-stable; };
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

  services.tailscale.enable = true;

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
      "terraform"
    ];
    taps = [
      "nikitabobko/tap"
      "crmne/tap"
      {
        name = "hashicorp/tap";
        trusted = true;
        force_auto_update = true;
      }
    ];
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
      "moonlight"
      # "psst"
      "slack"
      "spotifast"
      "tunnelblick"
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
      CustomUserPreferences = {
        "com.tinyspeck.slackmacgap" = {
          SlackNoAutoUpdates = true; # to avoid the helper tool notification
        };

        "com.apple.assistant.support" = {
          "Assistant Enabled" = false;
          "Siri Data Sharing Opt-In Status" = 2; # 2 is opt out
        };
        "com.apple.Siri" = {
          StatusMenuVisible = false;
          UserHasDeclinedEnable = true;
          VoiceTriggerUserEnabled = false;
          TypeToSiriEnabled = false;
        };

        "com.apple.CloudSubscriptionFeatures.optIn" = {
          "545129924" = false;
        };

        "com.apple.NetworkBrowser" = {
          DisableAirDrop = true;
        };

        "com.apple.controlcenter" = {
          AirplayRecieverEnabled = false;
        };

        "com.apple.lookup.shared" = {
          LookupSuggestionsDisabled = true;
        };

        "com.apple.gamed" = {
          Disabled = true;
        };

        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
          allowIdentifierForAdvertising = false;
          forceLimitAdTracking = true;
        };

        "com.apple.CrashReporter" = {
          DialogType = "none";
        };

        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.TimeMachine" = {
          DoNotOfferNewDisksForBackup = true;

        };
      };
      ".GlobalPreferences"."com.apple.mouse.scaling" = 3.0;
      universalaccess = {
        reduceTransparency = true;
        reduceMotion = true;
      };
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
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.001;
        NSDocumentSaveNewDocumentsToCloud = false;
      };

      dock = {
        autohide = true;
        tilesize = 40;
        show-recents = false;
        launchanim = false;
        mru-spaces = false;
        expose-group-apps = true;
        expose-animation-duration = 0.1;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        mineffect = "scale";
        # 1 = disabled
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };

      spaces.spans-displays = true;

      WindowManager = {
        GloballyEnabled = false;
        EnableTilingByEdgeDrag = false;
        EnableTopTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableStandardClickToShowDesktop = false;
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

      loginwindow.GuestEnabled = false;

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
    };
  };

    activationScripts.postActivation.text = ''
      echo "disabling Handoff / Universal Clipboard and Photos hot-plug..." >&2
      sudo -u ${user} defaults -currentHost write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false
      sudo -u ${user} defaults -currentHost write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool false
      sudo -u ${user} defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
    '';
  };
}
