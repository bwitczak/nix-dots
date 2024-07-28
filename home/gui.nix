{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.stylix.base16Scheme) slug palette;
in {

  stylix.targets = {
    zathura.enable = false;
    zellij.enable = false;
  };

  programs = {
    zathura = {
      enable = true;
      options = with config.lib.stylix.colors.withHashtag; {
        selection-clipboard = "clipboard";
        recolor = "true";
        recolor-keephue = "true";
        font = "${config.stylix.fonts.serif.name} ${toString config.stylix.fonts.sizes.popups}";
        completion-bg = base02;
        completion-fg = base0C;
        completion-highlight-bg = base0C;
        completion-highlight-fg = base02;
        default-fg = base01;
        highlight-active-color = base0D;
        highlight-color = base0A;
        index-active-bg = base0D;
        inputbar-bg = base00;
        inputbar-fg = base04;
        notification-bg = base09;
        notification-error-bg = base08;
        notification-error-fg = base00;
        notification-fg = base00;
        notification-warning-bg = base08;
        notification-warning-fg = base00;
        recolor-darkcolor = base06;
        statusbar-bg = base01;
        default-bg = "rgba(0,0,0,0.7)";
        recolor-lightcolor = "rgba(256,256,256,0)";
      };
      mappings = {
      "h" = "feedkeys '<C-Left>'";
      "j" = "feedkeys '<C-Down>'";
      "k" = "feedkeys '<C-Up>'";
      "l" = "feedkeys '<C-Right>'";
      "i" = "recolor";
      "f" = "toggle_fullscreen";
      "[fullscreen] i" = "recolor";
      "[fullscreen] f" = "toggle_fullscreen";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        # Environment
        env = {
          TERM = "xterm-256color";
        };
        # Colors
        colors = {
          primary = {
            background = lib.mkDefault "0x1E1E2E";
            foreground = lib.mkDefault "0xd6d6d6";
          };
          cursor = {
            text = lib.mkDefault "0xCDD6F4";
            cursor = lib.mkDefault "0xD9D9D9";
          };
          bright = {
            black = lib.mkDefault "0x5C6370";
            red = lib.mkDefault "0xE86671";
            green = lib.mkDefault "0x98C379";
            yellow = lib.mkDefault "0xE5C07B";
            blue = lib.mkDefault "0x61AFEF";
            magenta = lib.mkDefault "0xC678DD";
            cyan = lib.mkDefault "0x54AFBC";
            white = lib.mkDefault "0xf7f7f7";
          };
          normal = {
            black = lib.mkDefault "0x181A1F";
            red = lib.mkDefault "0xE86671";
            green = lib.mkDefault "0x98C379";
            yellow = lib.mkDefault "0xE5C07B";
            blue = lib.mkDefault "0x61AFEF";
            magenta = lib.mkDefault "0xC678DD";
            cyan = lib.mkDefault "0x54AFBC";
            white = lib.mkDefault "0xABB2BF";
          };
          dim = {
            black = lib.mkDefault "0x181A1F";
            red = lib.mkDefault "0x74423f";
            green = lib.mkDefault "0x98C379";
            yellow = lib.mkDefault "0xE5C07B";
            blue = lib.mkDefault "0x61AFEF";
            magenta = lib.mkDefault "0x6e4962";
            cyan = lib.mkDefault "0x5c8482";
            white = lib.mkDefault "0x828282";
          };
        };

        # Font
        font = {
          size = lib.mkDefault 13;
        };

        # Window
        window = {
          decorations = "full";
          padding = {
            x = 12;
            y = 12;
          };
        };

        # Scrolling
        scrolling = {
          history = 1000;
          multiplier = 3;
        };

        # Mouse
        mouse = {
          hide_when_typing = false;
        };

        # Shell
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = ["-l" "-c" "zellij"];
        };
      };
    };
  };
  services = {
    blueman-applet.enable = true;
    hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
        };
        # listener = {
        #   timeout = 300;
        #   on-timeout = "${lib.getExe pkgs.dvd-zig}";
        # };
      };
    };
    mako = {
      enable = true;
      defaultTimeout = 5000;
      maxIconSize = 128;
      borderSize = 0;
      format = ''<span foreground="#${palette.base0B}"><b><i>%s</i></b></span>\n<span foreground="#${palette.base0C}">%b</span>'';
      borderRadius = 10;
      padding = "10";
      width = 330;
      height = 200;
    };
  };
}
