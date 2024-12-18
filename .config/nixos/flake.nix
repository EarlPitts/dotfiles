{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }: {
    nixosConfigurations.T480 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules =
        [ ./hosts/default/configuration.nix home-manager.nixosModules.default ];
    };
    darwinConfigurations."FYPYG0PQFC" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      system = "aarch64-darwin";
      modules = [
        ./hosts/darwin/configuration.nix
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
