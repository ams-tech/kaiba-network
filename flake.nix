{
  description = "Infrastructure definitions for the kaiba.network domain";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  output = { self, nixpkgs }@inputs:
  {
    nixosModules = {
      web = import "./modules/web.nix";
    };
  };
}