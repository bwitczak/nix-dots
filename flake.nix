{
  description = "Nix Flake for Zen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # prismlauncher = {
    #   url = "github:Diegiwg/PrismLauncher-Cracked?ref=v8.4.1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    ### MY FLAKES ###
    # lem = {
    #   url = "github:71zenith/lem-flake";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "flake-utils";
    #   };
    # };
    # dvd-zig = {
    #   url = "github:71zenith/dvd-zig";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "flake-utils";
    #   };
    # };
    my-assets = {
      url = "github:71zenith/assets";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    # scraperwolf = {
    #   url = "github:71zenith/scraperwolf";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "flake-utils";
    #   };
    # };
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    ### NOTE: DECLARE USER ###
    pcName = "theonionocean";
    myUserName = "bwitczak";
    mail = "blaise.witczak@gmail.com";

    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    # HACK: nur prevent infinite recursion
    nurNoPkgs = import inputs.nur {
      nurpkgs = import nixpkgs {system = "x86_64-linux";};
    };

    caches = {
      nix.settings = {
        builders-use-substitutes = true;
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://nixpkgs-wayland.cachix.org"
          "https://cache.garnix.io"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
      };
    };
    overlays = {
      nixpkgs.overlays = with inputs; [
        # prismlauncher.overlays.default
        hyprland.overlays.default
        # dvd-zig.overlays.default
        my-assets.overlays.default
        (import ./pkgs)
        # lem.overlays.default
        # scraperwolf.overlays.default
      ];
    };
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        packages = with pkgs; [lazygit alejandra nil];
        shellHook = ''
          printf "\e[3m\e[1m%s\em\n" "Nix development environment is ready."
        '';
      };

      node = pkgs.mkShell {
        packages = with pkgs; [lazygit nodejs_20 pnpm];
        shellHook = ''
          printf "\e[3m\e[1m%s\em\n" "NodeJS development environment is ready."
        '';
      };

      rust = pkgs.mkShell {
        packages = with pkgs; [lazygit rustc cargo rustfmt clippy];
        shellHook = ''
          printf "\e[3m\e[1m%s\em\n" "Rust development environment is ready."
        '';
      };

      csharp = pkgs.mkShell {
        packages = with pkgs; [lazygit dotnet-sdk_8];
        shellHook = ''
          printf "\e[3m\e[1m%s\em\n" "C# development environment is ready."
        '';
      };
    };

    nixosConfigurations.${pcName} = nixpkgs.lib.nixosSystem {
      specialArgs = {
      inherit inputs nurNoPkgs;
      inherit pcName myUserName mail;
      };
      modules = with inputs; [
        caches
        overlays
        stylix.nixosModules.stylix
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        # sops-nix.nixosModules.sops
        # ./hosts/${pcName}/nixos/config.nix
        (import ./nixos/config.nix)
      ];
    };
  };
}
