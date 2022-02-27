{ lib, pkgs, ... }: {
  home-manager.users.rhoriguchi.home.file.".docker/config.json".source =
    lib.mkForce ((pkgs.formats.json { }).generate "config.json" { auths = (import ../secrets.nix).docker.auths; });
}
