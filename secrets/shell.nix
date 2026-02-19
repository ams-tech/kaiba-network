{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    import ./configuration.nix
  ];
  shellHook = ''
    echo "Welcome to the project dev shell!"
    export NODE_ENV=development
  '';
}