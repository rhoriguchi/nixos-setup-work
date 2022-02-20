{ lib, ... }: {
  imports = [ (import "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration/rhoriguchi/nautilus.nix") ];

  home-manager.users.rhoriguchi.xdg.configFile."gtk-3.0/bookmarks".text = lib.mkForce ''
    file:///media/homant
  '';
}
