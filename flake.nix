{
  description = "Infrastructure definitions for kaiba-network.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };
  outputs = { self, nixpkgs, nixos-raspberrypi, ... }@inputs:
  let 
    kaiba_network_modules = {
      web = import ./modules/web.nix;
      homeserver = import ./modules/homeserver.nix;
    };
  in 
  {
    nixosModules = kaiba_network_modules;
    nixosConfigurations = {
      warp = import ./systems/warp.nix{
          inherit nixos-raspberrypi inputs kaiba_network_modules;
      };
    };
  };
}
