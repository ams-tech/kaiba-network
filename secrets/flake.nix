{
  description = "My project dev shell";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.hello pkgs.git ];
      shellHook = '' echo "Welcome to the dev shell!" '';
    };
  };
}