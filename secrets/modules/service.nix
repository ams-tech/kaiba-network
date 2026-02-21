{ config, lib, pkgs, ... }:

{
  # To enable the service for decoding secrets, you need to set `services.helloNixosTests.enable = true`
  options = {
    services.kaibaNetworkSecretsTest = {
      enable = lib.mkEnableOption "kaibaNetworkSecretsTest";
    };
  };

  config = lib.mkIf config.services.kaibaNetworkSecretsTest.enable {
    systemd.services.hello = {
      description = "Says hello on login.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.hello}/bin/hello -g 'Hello, User!'";
      };
    };
  };
}
