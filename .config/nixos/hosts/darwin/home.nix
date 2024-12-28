{ pkgs, ... }:

{
  imports = [
    ../shared/home.nix
    ./aerospace.nix
  ];

  home.username = "I348749";
  home.homeDirectory = "/Users/I348749";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program /opt/homebrew/bin/pinentry-mac
    max-cache-ttl 60480000
    default-cache-ttl 60480000
  '';

  services.aerospace.enable = true;

  home.packages = with pkgs; [
    k9s
    iproute2mac
    postgresql
    zathura
    bruno-cli
    openvpn

    (google-cloud-sdk.withExtraComponents
      (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
        gsutil
        bq
        core
        kubectl
        alpha
        beta
      ])
    )

    # Langs
    nodejs
    phpactor
    python3
    pyright
  ];
}
