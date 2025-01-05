{ pkgs, ... }:

{
  imports = [ ../shared/home.nix ./aerospace.nix ];

  home.username = "I348749";
  home.homeDirectory = "/Users/I348749";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry_mac;
  };

  services.aerospace.enable = true;

  home.packages = with pkgs; [
    k9s
    iproute2mac
    postgresql
    zathura
    bruno-cli
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
}
