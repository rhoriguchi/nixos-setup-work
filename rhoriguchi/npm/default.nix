{ lib, ... }: {
  home-manager.users.rhoriguchi.home.file.".npmrc".text = lib.replaceStrings [ "USERNAME" "DEFAULT_CREDENTIAL" "FLOWABLE_CREDENTIAL" ] [
    "ryan.horiguchi@mimacom.com"
    (import ../../secrets.nix).node.credentials.default
    (import ../../secrets.nix).node.credentials.flowable
  ] (builtins.readFile ./.npmrc);
}
