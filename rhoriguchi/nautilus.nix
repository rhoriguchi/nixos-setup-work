{ lib, ... }: {
  home-manager.users.rhoriguchi.xdg.configFile."gtk-3.0/bookmarks".text = lib.mkForce ''
    file:///media/homant
  '';
}
