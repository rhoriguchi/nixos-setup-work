{ pkgs, lib, ... }: {
  imports = [ <nixpkgs/nixos/modules/profiles/hardened.nix> ];

  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;

  security = {
    # apparmor.policies."extra-profiles" = let
    #   excludePolicies = [ "README" ];

    #   dir = "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles";
    #   policies = lib.filterAttrs (key: _: !(lib.elem key excludePolicies)) (builtins.readDir dir);
    # in {
    #   enable = true;
    #   profile = lib.concatStringsSep "\n" (lib.mapAttrsToList (key: _: ''include "${dir}/${key}"'') policies);
    # };

    # apparmor.policies = let
    #   excludePolicies = [ "README" ];

    #   dir = "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles";
    #   policies = lib.filterAttrs (key: _: !(lib.elem key excludePolicies)) (builtins.readDir dir);
    # in lib.mapAttrs (key: _: {
    #   enable = true;

    #   profile = ''
    #     include "${pkgs.apparmor-profiles}/etc/apparmor.d"
    #     include "${dir}/${key}"
    #   '';
    # }) policies;

    # TODO figure out how it works now
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/security/apparmor.nix#L20
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/security/apparmor.nix#L44
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/security/apparmor/profiles.nix

    # apparmor.policies."bin.ping".profile = lib.mkIf apparmor.policies."bin.ping".enable ''
    #   include "${pkgs.iputils.apparmor}/bin.ping"
    #   include "${pkgs.inetutils.apparmor}/bin.ping"
    #   # Note that including those two profiles in the same profile
    #   # would not work if the second one were to re-include <tunables/global>.
    # '';

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

  virtualisation.virtualbox.host.enableHardening = true;
}
