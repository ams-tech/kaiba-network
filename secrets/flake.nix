{
  description = "Secrets for kaiba-network";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, flake-utils, sops-nix }@inputs:
    {
      #nixosModules = {
      #  kaibaNetworkSecretsTest = import ./modules/service.nix;
      #};
    } // flake-utils.lib.eachDefaultSystem
      (system:
        let       
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          checks = {
            testSecretsAvailability = pkgs.callPackage ./test/sample-secret.nix { inherit self; };
          };
        }
      );
}