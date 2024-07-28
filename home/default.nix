{
  pkgs,
  config,
  lib,
  myUserName,
  osConfig,
  ...
}: let
  scripts = import ../pkgs/scripts.nix {inherit pkgs lib;};
in {
  stylix.targets.kde.enable = false;
  imports = [
  ./modules
    ./cli.nix
    ./gui.nix
    ./mpv.nix
    ./zsh.nix
    ./waybar.nix
    ./git.nix
    ./rofi.nix
    ./xdg.nix
    ./firefox.nix
    ./hyprland.nix
  ];

  home = {
    username = myUserName;
    stateVersion = "24.05";
    sessionVariables = {
      MANPAGER = "less -R --use-color -Dd+m -Du+b -DP+g";
      MANROFFOPT = "-P -c";
      LESS = "-R --use-color";
    };
  };
  fonts.fontconfig = {inherit (osConfig.fonts.fontconfig) defaultFonts;};

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  stylix.targets.gtk.extraCss = with config.lib.stylix.colors.withHashtag; ''
    @define-color accent_color ${base0A};
    @define-color accent_bg_color ${base0A};
  '';
  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-hyprland];
    config.common.default = ["hyprland" "gtk"];
    xdgOpenUsePortal = true;
  };

  xresources.properties = with config.lib.stylix.colors.withHashtag; {
    "bar.background" = base02;
    "bar.foreground" = base0B;
    "bar.font" = "${config.stylix.fonts.serif.name} ${toString config.stylix.fonts.sizes.desktop}";
    "window.foreground" = base04;
    "window.background" = base02;
    "mark.background" = base0A;
  };
}
