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

    # TODO remove when namespace with chrome works
    kernelPackages = pkgs.linuxPackages_5_4;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = (import "${(import ./rhoriguchi-nixos-setup.nix).path}/configuration/overlays") ++ (import ./overlays);
  };

  nix.autoOptimiseStore = true;

  system.stateVersion = "22.05";

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
      LC_TIME = "en_GB.UTF-8";
    };
  };

  networking = {
    hostName = "ryan-horiguchi-zrh";

    useDHCP = false;

    interfaces = {
      enp0s31f6.useDHCP = true; # Ethernet
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
        extraGroups = [ "docker" "networkmanager" "plugdev" "vboxusers" "wheel" ];
      };
    };
  };

  environment = {
    variables = rec {
      EDITOR = "nano";
      KUBE_EDITOR = EDITOR;
      NIXPKGS_ALLOW_UNFREE = "1";
      TERMINAL = "alacritty";
    };

    shellAliases = {
      l = null;
      ll = null;
    };

    gnome.excludePackages = [
      pkgs.gnome-connections
      pkgs.gnome-photos
      pkgs.gnome.epiphany
      pkgs.gnome.geary
      pkgs.gnome.gnome-calendar
      pkgs.gnome.gnome-characters
      pkgs.gnome.gnome-clocks
      pkgs.gnome.gnome-contacts
      pkgs.gnome.gnome-font-viewer
      pkgs.gnome.gnome-logs
      pkgs.gnome.gnome-maps
      pkgs.gnome.gnome-music
      pkgs.gnome.gnome-screenshot
      pkgs.gnome.gnome-terminal
      pkgs.gnome.gnome-weather
      pkgs.gnome.simple-scan
      pkgs.gnome.totem
      pkgs.gnome.yelp
    ];

    systemPackages = [
      pkgs.alacritty
      pkgs.citrix_workspace
      pkgs.curl
      pkgs.docker-compose
      pkgs.file
      pkgs.firefox
      pkgs.flameshot
      pkgs.git
      pkgs.git-crypt
      pkgs.git-lfs
      pkgs.gitkraken
      pkgs.glances
      pkgs.gnome.dconf-editor
      pkgs.gnome.networkmanager-openconnect
      pkgs.google-chrome
      pkgs.graphviz
      pkgs.haskellPackages.nixfmt
      pkgs.htop
      pkgs.jdk # TODO remove when lombok - spring issue is solved
      pkgs.jetbrains.idea-ultimate
      pkgs.k9s
      pkgs.kubernetes
      pkgs.libreoffice-fresh
      pkgs.maven
      pkgs.nodejs
      pkgs.nodePackages.prettier
      pkgs.ntfs3g
      pkgs.openconnect-sso
      pkgs.openssl
      pkgs.pipenv
      pkgs.postgresql_13
      pkgs.postman
      pkgs.python3
      pkgs.python3Packages.pip
      pkgs.remmina
      pkgs.signal-desktop
      pkgs.spotify
      pkgs.sshpass
      pkgs.teams
      pkgs.tree
      pkgs.unzip
      pkgs.vlc
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

      displayManager.gdm = {
        enable = true;
        # TODO remove once teams screen sharing works with wayland
        wayland = false;
      };

      desktopManager.gnome.enable = true;

      libinput.enable = true;
    };

    gnome = {
      chrome-gnome-shell.enable = false;
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = false;
    };

    printing = {
      enable = true;

      drivers = [ pkgs.gutenprint ];
      webInterface = false;
    };

    onedrive.enable = true;

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
  };

  fonts.fonts = [ pkgs.montserrat ];

  virtualisation = {
    docker.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

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

    java = {
      enable = true;

      # TODO remove when lombok - spring issue is solved
      package = pkgs.jdk11;
    };

    npm.enable = true;
  };
}
