{ pkgs, config, lib, ... }:
let rhoriguchi = "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration/users/rhoriguchi";
in {
  imports = [
    (import "${rhoriguchi}/../home-manager.nix")

    (import "${rhoriguchi}/alacritty.nix")
    (import "${rhoriguchi}/flameshot.nix")
    (import "${rhoriguchi}/fzf.nix")
    (import "${rhoriguchi}/git")
    (import "${rhoriguchi}/gnome")
    (import "${rhoriguchi}/htop")
    (import "${rhoriguchi}/ssh.nix")
    (import "${rhoriguchi}/vscode.nix")
    (import "${rhoriguchi}/zsh.nix")

    ./autostart.nix
    ./docker.nix
    ./firefox
    ./maven
    ./npm
    ./onedrive.nix
  ];

  home-manager.users.rhoriguchi = {
    dconf.settings."org/gnome/desktop/background".picture-uri =
      lib.mkForce "file:${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";

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
