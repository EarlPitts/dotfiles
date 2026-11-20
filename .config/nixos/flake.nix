{
  description = "NixOS config flake";

  inputs = {
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      nix-darwin,
      home-manager,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations.T480 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; };
        };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ./hosts/default/configuration.nix
          home-manager.nixosModules.default
        ];
      };
      darwinConfigurations."FYPYG0PQFC" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable { system = "aarch64-darwin"; };
        };
        system = "aarch64-darwin";
        modules = [
          ./hosts/darwin/configuration.nix
          home-manager.darwinModules.home-manager
        ];
      };
      nixosConfigurations.hub = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/server/configuration.nix
          home-manager.nixosModules.default
        ];
      };
    };
}
