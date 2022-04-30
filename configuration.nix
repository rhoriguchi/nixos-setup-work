{ pkgs, lib, ... }:
let configs = "${(import ./rhoriguchi-nixos-setup.nix).path}/configuration/configs";
in {
  imports = [
    (import "${configs}/displaylink.nix")
    (import "${configs}/gnome.nix")
    (import "${configs}/i18n.nix")
    (import "${configs}/java.nix")
    (import "${configs}/javascript.nix")
    (import "${configs}/keyboard.nix")
    (import "${configs}/kotlin.nix")
    (import "${configs}/nix.nix")
    (import "${configs}/podman.nix")
    (import "${configs}/power-management.nix")
    (import "${configs}/printing.nix")
    (import "${configs}/python.nix")
    (import "${configs}/zsh.nix")

    ./hardening.nix
    ./rhoriguchi

    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.overlays = (import ./overlays);

  time.timeZone = "Europe/Zurich";

  networking = {
    hostName = "ryan-horiguchi-zrh";

    useDHCP = false;

    interfaces = {
      enp0s31f6.useDHCP = true; # Ethernet
      wlp0s20f3.useDHCP = true; # WiFi
    };

    networkmanager.unmanaged = [ "wlp0s20f3" ];

    wireless = {
      enable = true;
      userControlled.enable = true;
      extraConfig = ''
        p2p_disabled=1
      '';

      networks = (import ./secrets.nix).networking.wireless.networks;
    };
  };

  hardware = {
    bluetooth.enable = true;

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    openrazer.enable = true;
  };

  services = {
    xserver = {
      # TODO remove once teams screen sharing works with wayland
      displayManager.gdm.wayland = false;

      libinput.enable = true;
    };

    onedrive.enable = true;
  };

  virtualisation.virtualbox.host = {
    enable = true;
    # TODO commented till https://github.com/NixOS/nixpkgs/issues/163831 resolved
    # enableExtensionPack = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    htop.enable = true;
  };

  environment = {
    variables = {
      KUBE_EDITOR = "nano";
      TERMINAL = "alacritty";
    };

    systemPackages = [
      pkgs.alacritty
      pkgs.bat
      pkgs.citrix_workspace
      pkgs.curl
      pkgs.file
      pkgs.firefox
      pkgs.flameshot
      pkgs.git
      pkgs.git-crypt
      pkgs.git-lfs
      pkgs.gitkraken
      pkgs.glances
      pkgs.google-chrome
      pkgs.graphviz
      pkgs.haskellPackages.nixfmt
      pkgs.jetbrains.idea-ultimate
      pkgs.k9s
      pkgs.kubernetes
      pkgs.libreoffice-fresh
      pkgs.openconnect-sso
      pkgs.openssl
      pkgs.postgresql_13
      pkgs.postman
      pkgs.remmina
      pkgs.signal-desktop
      pkgs.spotify-unwrapped
      pkgs.sshpass
      pkgs.teams
      pkgs.tree
      pkgs.unzip
      pkgs.vlc
      pkgs.vscode
      pkgs.wpa_supplicant_gui
      pkgs.zip
    ];
  };

  users = {
    mutableUsers = false;

    users = {
      root.hashedPassword = "*";

      rhoriguchi = {
        isNormalUser = true;
        password = (import ./secrets.nix).users.users.rhoriguchi.password;
        extraGroups = [ "networkmanager" "plugdev" "podman" "vboxusers" "wheel" ];
      };
    };
  };
}
