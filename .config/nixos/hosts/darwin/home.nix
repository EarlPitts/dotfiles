{ pkgs, ... }:

{
  imports = [
    ../shared/home.nix
    ./aerospace.nix
  ];

  home = {
    username = "I348749";
    homeDirectory = "/Users/I348749";

    stateVersion = "23.11"; # Please read the comment before changing.
    file.".hushlogin".text = ""; # Disable login message

    packages = with pkgs; [
      k9s
      colima
      docker
      docker-compose
      iproute2mac
      postgresql
      zathura
      openvpn
      redis
      claude-code
      choose-gui

      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components;
        [
          gke-gcloud-auth-plugin
          gcloud-man-pages
          gsutil
          bq
          core
          kubectl
          alpha
          beta
        ]
      ))

      # Langs
      nodejs
      phpactor
      python3
    ];
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry_mac;
      maxCacheTtl = 60480000;
      defaultCacheTtl = 60480000;
    };

    aerospace.enable = true;
  };

}
