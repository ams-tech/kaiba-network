{ pkgs, inputs, config, ... }:

{
  services.pcscd.enable = true;

  sops = {
    age = {
      keyFile = "/path/to/age-yubikey-identity-XXXXXXXX.txt";
      plugins = [ pkgs.age-plugin-yubikey ];
      requirePcscd = true;  # Ensures pcscd is available during decryption
    };

    secrets.my-secret = {
      sopsFile = secrets/secrets.yaml;
    };
  };
}

