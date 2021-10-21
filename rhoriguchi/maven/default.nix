{ lib, ... }: {
  home-manager.users.rhoriguchi.home.file.".m2/settings.xml".text =
    lib.replaceStrings [ "USERNAME" "CREDENTIAL" ] [ "ryan.horiguchi@mimacom.com" (import ../../secrets.nix).maven.credential ]
    (builtins.readFile ./settings.xml);
}
