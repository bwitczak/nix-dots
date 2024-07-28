{
  config,
  inputs,
  pcName,
  ...
}: {
  services = {
  xserver.xkb = {
      layout = "pl";
      variant = "";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    blueman.enable = true;

    resolved = {
            enable = true;
          };
  };

  programs.nm-applet.enable = true;
      networking = {
        hostName = pcName;
        nameservers = ["1.1.1.1" "1.1.1.3"];
        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
        };
        wireless = {
          iwd.enable = true;
        };
      };

  # sound.enable = true;

  security = {
        # allow wayland lockers to unlock the screen
        pam.services = {
          swaylock.text = "auth include login";
          greetd.enableGnomeKeyring = true;
        };

        # userland niceness
        rtkit.enable = true;
      };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };


}
