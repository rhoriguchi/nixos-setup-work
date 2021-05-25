{ pkgs, ... }: {
  imports = [ <nixpkgs/nixos/modules/profiles/hardened.nix> ];

  security = {
    # TODO figure out how it works now
    # apparmor.profiles = [ "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles" ];

    lockKernelModules = false;
  };

  environment = {
    memoryAllocator.provider = "libc";

    systemPackages = [ pkgs.chkrootkit ];
  };

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.session]
    idle-delay=${toString (5 * 60)}
  '';
}
