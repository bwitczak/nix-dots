{
  stylix.targets.waybar = {
    enableLeftBackColors = false;
    enableRightBackColors = false;
    enableCenterBackColors = false;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        mod = "dock";
        height = 35;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;

        modules-left = ["custom/left" "custom/rofi" "custom/space" "hyprland/window" "custom/right"];
        modules-center = ["custom/left" "hyprland/workspaces" "custom/right" "custom/left" "temperature" "cpu" "memory" "network" "custom/right"];
        modules-right = ["custom/left" "backlight" "pulseaudio" "battery" "tray" "custom/right" "custom/left" "clock" "custom/right"];

        "hyprland/window" = {
          rewrite = {
            "(.*) - Brave" = "$1";
            "(.*) - Chromium" = "$1";
            "(.*) - Brave Search" = "$1";
            "(.*) - Outlook" = "$1";
            "(.*) Microsoft Teams" = "$1";
          };
          "separate-outputs" = true;
        };

        "cpu" = {
          interval = 10;
          format = "󰍛 {usage}%";
          format-alt = "{icon0}{icon1}{icon2}{icon3}";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        };

        "memory" = {
          "interval" = 10;
          "format" = "  {percentage}%";
        };

        "network" = {
          tooltip = true;
          format-wifi = "<span foreground='#FFFFFF'> {bandwidthDownBytes}</span> <span foreground='#FFFFFF'> {bandwidthUpBytes}</span>";
          format-ethernet = "<span foreground='#FF8B49'> {bandwidthDownBytes}</span> <span foreground='#FF6962'> {bandwidthUpBytes}</span>";
          tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = " 󰖪 ";
          tooltip-format-disconnected = "Disconnected";
          interval = 2;
        };

        "temperature" = {
          hwmon-path = ["/sys/class/hwmon/hwmon1/temp1_input" "/sys/class/thermal/thermal_zone0/temp"];
          format = " {temperatureC}°C";
        };

        "custom/space" = {
          format = " ┃ {}";
        };

        "custom/rofi" = {
          format = "{}";
          on-click = "pkill rofi || rofi -show drun";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          on-click = "activate";
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "婢";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
        };

        "tray" = {
          "icon-size" = 20;
          spacing = 9;
        };

        "clock" = {
          format = "  {:%H:%M}";
        };

        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = ["󱩏" "󱩑" "󱩓" "󱩕" "󰛩"];
        };

        # Modules for padding
        "custom/left" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/right" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: "CaskaydiaMono Nerd Font";
          font-weight: bold;
          font-size: 13px;
          min-height: 10px;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0);
          transition-property: background-color;
          transition-duration: .5s;
      }

      #battery,
      #temperature,
      #cpu,
      #memory,
      #clock,
      #window,
      #workspaces,
      #custom-rofi,
      #custom-space,
      #tray,
      #pulseaudio,
      #backlight,
      #network,
      #custom-right,
      #custom-left {
         color: @main-color;
         background: rgba(36, 41, 50, 0.9);
         margin: 4px 0px 4px 0px;
         opacity: 1;
         border: 0px solid #181825;
      }

      tooltip {
          background: @tool-bg;
          color: @tool-color;
          border-radius: 22px;
          border-width: 2px;
          border-style: solid;
          border-color: #11111b;
      }

      #workspaces button {
          box-shadow: none;
          text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          margin-top: 3px;
          margin-bottom: 3px;
          padding-left: 3px;
          padding-right: 3px;
          color: #ffffff;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.active {
          background: rgba(0, 0, 0, 1);
          color: #FFFFFF;
          margin-left: 3px;
          padding-left: 12px;
          padding-right: 12px;
          margin-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
          background: #64727D;
          border: none;
      }

      #workspaces {
          padding: 0px;
          padding-left: 5px;
          padding-right: 5px;
      }

      #custom-rofi {
          color: #ffffff;
          padding-left: 0px;
          padding-right: 10px;
      }

      #temperature {
          color: #ffffff;
          padding-left: 0px;
          padding-right: 19px;
      }

      #temperature.critical {
          color: #ff0000;
          padding-left: 0px;
          padding-right: 19px;
      }

      #cpu, #memory {
        padding-right: 19px;
      }

      #backlight {
          color: #ffffff;
          padding-left: 0px;
          padding-right: 19px;
      }

      #pulseaudio {
          color: #ffffff;
          padding-left: 0px;
          padding-right: 19px;
      }

      #battery {
          color: #ffffff;
          padding-left: 0px;
          padding-right: 19px;
      }

      #tray {
        padding-left: 0px;
        padding-right: 0px;
      }

      #network {
         padding-left: 0px;
      }

      #clock {
         color: #ffffff;
         padding-left: 0px;
         padding-right: 0px;
      }

      #custom-right {
          margin-right: 9px;
          padding-right: 3px;
          border-radius: 0px 22px 22px 0px;
      }

      #custom-left {
          margin-left: 9px;
          padding-left: 3px;
          border-radius: 22px 0px 0px 22px;
      }
    '';
  };
}
