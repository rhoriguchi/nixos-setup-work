{ pkgs, config, lib, ... }:
let
  configuration = "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration";
  rhoriguchi = "${configuration}/rhoriguchi";
in {
  imports = [
    (import "${configuration}/home-manager.nix")

    (import "${rhoriguchi}/alacritty.nix")
    (import "${rhoriguchi}/conky.nix")
    (import "${rhoriguchi}/flameshot.nix")
    (import "${rhoriguchi}/fzf.nix")
    (import "${rhoriguchi}/git.nix")
    (import "${rhoriguchi}/gnome")
    (import "${rhoriguchi}/htop.nix")
    (import "${rhoriguchi}/onedrive.nix")
    (import "${rhoriguchi}/ssh.nix")
    (import "${rhoriguchi}/zsh.nix")

    ./autostart.nix
    ./citrix
    ./docker.nix
    ./firefox
    ./maven
    ./npm
    ./vscode.nix
  ];

  home-manager.users.rhoriguchi = {
    dconf.settings = {
      "org/gnome/desktop/background".picture-uri =
        lib.mkForce "file://${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";

      # TODO remove once suspend works again
      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "nothing";
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };
    };

    programs = {
      git = {
        userEmail = lib.mkForce "ryan.horiguchi@mimacom.com";
        signing.key = lib.mkForce "16DCA138762BE10A92A826F21E6BE7F241D5F77A";
      };

      ssh.matchBlocks = lib.mkForce {
        "github.com" = {
          user = "git";
          identityFile = "${config.users.users.rhoriguchi.home}/.ssh/github_rsa";
        };

        "code.flowable.com".user = "git";
      };
    };
  };
}
