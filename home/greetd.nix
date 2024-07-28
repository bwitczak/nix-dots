{
  lib,
  pkgs,
  config,
  default,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "kynaios";
      };
      default_session = initial_session;
    };
  };
}
