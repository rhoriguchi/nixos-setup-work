{ pkgs, lib, config, ... }:
let packages = lib.unique (map (p: "${p.name}") (config.environment.systemPackages ++ config.users.users.rhoriguchi.packages));
in {
  imports = [ (import "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration/users/rhoriguchi/autostart.nix") ];

  home-manager.users.rhoriguchi.xdg.configFile = {
    "autostart/teams.desktop" = lib.mkIf (builtins.elem pkgs.teams.name packages) {
      text = ''
        [Desktop Entry]
        Name=Microsoft Teams
        Icon=teams
        Exec=${pkgs.teams}/bin/teams %U
        Terminal=false
        Type=Application
        X-GNOME-Autostart-enabled=true
      '';
    };

    "autostart/thunderbird.desktop" = lib.mkIf (builtins.elem pkgs.thunderbird.name packages) {
      text = ''
        ${builtins.readFile "${pkgs.thunderbird}/share/applications/thunderbird.desktop"}
        X-GNOME-Autostart-enabled=true
      '';
    };
  };
}
