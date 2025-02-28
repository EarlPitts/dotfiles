{ pkgs, ... }:

{
  imports = [ ../shared/home.nix ./aerospace.nix ];

  home = {
    username = "I348749";
    homeDirectory = "/Users/I348749";

    stateVersion = "23.11"; # Please read the comment before changing.
    file.".hushlogin".text = ""; # Disable login message

    packages = with pkgs; [
      k9s
      iproute2mac
      postgresql
      zathura
      openvpn

      (google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
        gsutil
        bq
        core
        kubectl
        alpha
        beta
      ]))

      # Langs
      nodejs
      vue-language-server
      typescript-language-server
      python3
    ];
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry_mac;
      maxCacheTtl = 60480000;
      defaultCacheTtl = 60480000;
    };

    aerospace.enable = true;
  };

}
