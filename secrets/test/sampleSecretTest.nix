{ pkgs }:


pkgs.testers.nixosTest {
  name = "sampleSecretTest";
  nodes.machine = { config, pkgs, ... }: {
    imports = [ ];
  };

  # This is a Python "unittest.TestCase", where `t` is the testcase object you can call "asserts" against
  # https://nixos.org/manual/nixos/stable/#sec-writing-nixos-tests
  testScript = ''
    machine.wait_for_unit("default.target")
    t.assertIn("Linux", machine.succeed("uname"), "Wrong OS")
  '';
}