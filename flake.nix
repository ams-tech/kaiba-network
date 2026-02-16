{
  description = "Infrastructure definitions for the kaiba.network domain";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs = { self, nixpkgs, ... }:
  {
    nixosModules = {
      web = import ./modules/web.nix;
    };
    nixosConfigurations = {
      warp = import ./systems/warp.nix;
    };
  };
}
