{ pkgs, lib, config, ... }:
let packageNames = lib.unique (map (package: package.name) (config.environment.systemPackages ++ config.users.users.rhoriguchi.packages));
in {
  home-manager.users.rhoriguchi.xdg.configFile."autostart/${pkgs.teams.pname}.desktop" =
    lib.mkIf (lib.elem pkgs.teams.name packageNames) { source = "${pkgs.teams}/share/applications/teams.desktop"; };
}
