{ pkgs, lib, ... }: {
  imports = [
    ./hardening.nix
    ./rhoriguchi

    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # TODO remove when openrazer drivers works on 5.10
    kernelPackages = pkgs.linuxPackages_5_4;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = (import "${(import ./rhoriguchi-nixos-setup.nix).path}/configuration/overlays") ++ (import ./overlays);
  };

  nix.autoOptimiseStore = true;

  system.stateVersion = "21.05";

  time.timeZone = "Europe/Zurich";

  documentation.doc.enable = false;

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_COLLATE = "en_US.UTF-8";
      LC_MEASUREMENT = "de_CH.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "de_CH.UTF-8";
      LC_NUMERIC = "de_CH.UTF-8";
      LC_PAPER = "de_CH.UTF-8";
      LC_TIME = "de_CH.UTF-8";
    };
  };

  networking = {
    hostName = "ryan-horiguchi-zrh";

    useDHCP = false;

    interfaces = {
      enp0s31f6.useDHCP = true; # Ethernet
      enp43s0u1u3u1.useDHCP = true; # Icy Box IB-DK2106-C
      wlp0s20f3.useDHCP = true; # WiFi
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

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;

    users = {
      root.hashedPassword = "*";

      rhoriguchi = {
        isNormalUser = true;
        password = (import ./secrets.nix).users.users.rhoriguchi.password;
        extraGroups = [ "docker" "networkmanager" "plugdev" "wheel" ];
      };
    };
  };

  environment = {
    variables = {
      EDITOR = "nano";
      NIXPKGS_ALLOW_UNFREE = "1";
      TERMINAL = "alacritty";
    };

    shellAliases = {
      l = null;
      ll = null;
    };

    gnome3.excludePackages = [
      pkgs.gnome-connections
      pkgs.gnome-photos
      pkgs.gnome3.epiphany
      pkgs.gnome3.geary
      pkgs.gnome3.gnome-calendar
      pkgs.gnome3.gnome-characters
      pkgs.gnome3.gnome-clocks
      pkgs.gnome3.gnome-contacts
      pkgs.gnome3.gnome-font-viewer
      pkgs.gnome3.gnome-maps
      pkgs.gnome3.gnome-music
      pkgs.gnome3.gnome-screenshot
      pkgs.gnome3.gnome-shell-extensions
      pkgs.gnome3.gnome-terminal
      pkgs.gnome3.gnome-weather
      pkgs.gnome3.simple-scan
      pkgs.gnome3.totem
      pkgs.gnome3.yelp
    ];

    systemPackages = [
      pkgs.alacritty
      pkgs.curl
      pkgs.firefox
      pkgs.flameshot
      pkgs.git
      pkgs.git-crypt
      pkgs.gitkraken
      pkgs.gnome3.dconf-editor
      pkgs.gnome3.networkmanager-openconnect
      pkgs.haskellPackages.nixfmt
      pkgs.htop
      pkgs.jetbrains.idea-ultimate
      pkgs.jetbrains.webstorm
      pkgs.kubernetes
      pkgs.libreoffice-fresh
      pkgs.maven
      pkgs.nodejs
      pkgs.ntfs3g
      pkgs.openconnect-sso
      pkgs.openssl
      pkgs.signal-desktop
      pkgs.spotify
      pkgs.sshpass
      pkgs.teams
      pkgs.unzip
      pkgs.vscode
      pkgs.yarn
    ];
  };

  console.useXkbConfig = true;

  services = {
    xserver = {
      enable = true;

      layout = "ch";
      xkbModel = "pc105";
      xkbVariant = "de_nodeadkeys";

      displayManager = {
        gdm.enable = true;

        sessionCommands = "${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0";
      };

      desktopManager.gnome3.enable = true;

      libinput.enable = true;

      videoDrivers = [ "displaylink" "modesetting" ];
    };

    gnome3 = {
      chrome-gnome-shell.enable = false;
      gnome-initial-setup.enable = lib.mkForce false;
    };

    printing = {
      enable = true;

      drivers = [ pkgs.gutenprint ];
      webInterface = false;
    };

    onedrive.enable = true;

    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };

  fonts.fonts = [ pkgs.montserrat ];

  virtualisation.docker.enable = true;

  programs = {
    dconf.enable = true;

    nano = {
      nanorc = ''
        set constantshow
        set linenumbers
        set softwrap
        set tabsize 4
        set tabstospaces
        unset nonewlines
      '';

      syntaxHighlight = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    zsh.enable = true;

    java.enable = true;

    npm.enable = true;
  };
}
