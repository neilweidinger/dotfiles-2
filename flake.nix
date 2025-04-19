{
  description = "Neil's nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."Neils-MacBook-Air-2" = nix-darwin.lib.darwinSystem {
      modules = [ ./nix/configuration.nix ./nix/system-defaults.nix ];
    };
  };
}
