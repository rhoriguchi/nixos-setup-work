{
  imports = [
    (import "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration/rhoriguchi")

    ./autostart.nix
    ./citrix
    ./docker.nix
    ./firefox
    ./git.nix
    ./gnome.nix
    ./maven
    ./nautilus.nix
    ./npm
    ./ssh.nix
    ./vscode.nix
  ];
}
