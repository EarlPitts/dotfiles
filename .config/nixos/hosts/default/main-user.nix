{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options = {
    main-user.enable
      = lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "ben";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "unix";
      description = "My user";
      extraGroups = [ "wheel" "power" ];
      shell = pkgs.zsh;
    };
  };
}


