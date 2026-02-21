{
  description = "Secrets for kaiba-network";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      nixosModules = {
        kaibaNetworkSecretsTest = import ./modules/service.nix;
      };
    } // flake-utils.lib.eachDefaultSystem
      (system:
        let
          # Create a packages overlay with our test service built in           
          overlay = final: prev: {
            kaibaNetworkTestSecret = self.packages.${system}.kaibaNetworkTestSecret;
          };
          pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
        in
        {
          testSecretsAvailability = pkgs.nixosTest 
          {
            name = "test-secrets-availability";
            nodes.machine = 
            {
              config = {
                imports = [ self.nixosModules.secretsAvailabilityTest ];
                services.kaibaNetworkTestSecret.enable = true;
              };
              testScript = ''
                machine.wait_for_unit("helloWorld.service")
                machine.wait_for_open_port(8000)
                assert "Hello world!" in machine.succeed("curl localhost:8000")
              '';
            };
          };
        }
      );
}