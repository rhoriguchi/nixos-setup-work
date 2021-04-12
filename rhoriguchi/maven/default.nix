{ lib, ... }: {
  home-manager.users.rhoriguchi.home.file.".m2/settings.xml".text = lib.replaceStrings [ "USER_NAME" "USER_ENCRYPTED_PASSWORD" ] [
    "ryan.horiguchi@mimacom.com"
    (import ../../secrets.nix).maven.encryptedPassword
  ] (builtins.readFile ./settings.xml);
}
