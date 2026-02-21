{ self, pkgs }:

# 
pkgs.testers.nixosTest {
  name = "sampleSecretTest";
  nodes.machine = { config, pkgs, ... }: {
  };

  # This is a Python "unittest.TestCase", where `t` is the testcase object you can call "asserts" against
  testScript = ''
    machine.wait_for_unit("default.target")
    t.assertIn("Linux", machine.succeed("uname"), "Wrong OS")
  '';
}