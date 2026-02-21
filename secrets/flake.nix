{
  description = "Secrets for kaiba-network";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, flake-utils, sops-nix }@inputs:
    {
      nixosModules = {
        kaibaNetworkSecretsTest = import ./modules/service.nix;
      };
    } // flake-utils.lib.eachDefaultSystem
      (system:
        let       
          pkgs = import nixpkgs { system = system; };
        in
        {
          packages = {
            sampleSecretTest = pkgs.callPackage ./test/sampleSecretTest.nix {};
          };
          checks = {
            testSecretsAvailability = pkgs.testers.nixosTest {
              name = "sampleSecretTest";
              nodes.machine = { config, pkgs, ... }: {
                imports = [ self.nixosModules.kaibaNetworkSecretsTest ];
                services.kaibaNetworkSecretsTest.enable = true;
              };

              # This is a Python "unittest.TestCase", where `t` is the testcase object you can call "asserts" against
              # https://nixos.org/manual/nixos/stable/#sec-writing-nixos-tests
              testScript = ''
                machine.wait_for_unit("default.target")
                t.assertIn("Linux", machine.succeed("uname"), "Wrong OS")
              '';
            };
          };
        }
      );
}