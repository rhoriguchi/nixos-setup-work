{ pkgs, ... }: {
  imports = [ <nixpkgs/nixos/modules/profiles/hardened.nix> ];

  security = {
    # TODO figure out how it works now
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/security/apparmor.nix#L20
    # apparmor.profiles = [ "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles" ];

    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/security/apparmor.nix#L44
    # https://github.com/NixOS/nixpkgs/blob/nixos-21.05/nixos/modules/security/apparmor/profiles.nix
    # apparmor.policies.profile = builtins.concatStringsSep "\n" [ "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles" ];

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
