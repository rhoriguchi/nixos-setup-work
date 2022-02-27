{ lib, pkgs, ... }: {
  home-manager.users.rhoriguchi.dconf.settings."org/gnome/desktop/background".picture-uri =
    lib.mkForce "file://${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
}
