{
  pkgs,
  config,
  inputs,
  pcName,
  myUserName,
  mail,
  nurNoPkgs,
  lib,
  ...
}: let
  home = user: "/home/${user}";
in {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./packages.nix
    ./stylix.nix
  ];

  config = {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];
      log-lines = 30;
      http-connections = 50;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          consoleMode = "max";
        };
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_zen;
    };

    documentation = {
      enable = true;
      dev.enable = true;
    };

    services = {
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
            user = myUserName;
          };
          default_session = initial_session;
        };
      };

      # NOTE: calibre drive detection
      udisks2.enable = true;


      # NOTE: nautilus trash support
      gvfs.enable = true;
      # xserver.videoDrivers = ["nvidia"];
    };

    time.timeZone = "Europe/Warsaw";
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };

    # NOTE: for systemd completion
    # environment.pathsToLink = ["/share/zsh"];
    programs = {
      zsh.enable = true;
      hyprland.enable = true;
      nh = {
        enable = true;
        flake = "${home myUserName}/nix";
      };

      nix-ld.enable = true;
    };

    users.users = {
      ${myUserName} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["wheel" "input"];
      };
    };

    home-manager = {
      backupFileExtension = "bak";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
      inherit inputs nurNoPkgs;
      inherit pcName myUserName mail;
      };
      users.${myUserName} = import ../home;
    };

    nixpkgs.config = import ../home/nixpkgs.nix;

    system.stateVersion = "24.05";
  };
}
