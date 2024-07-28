{
  default,
  pkgs,
  config,
  lib,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = let
      inherit (default) xcolors;
    in {
      clock = true;
      font = "CaskaydiaMono Nerd Font *";
      image = "${pkgs.my-walls}/share/wallpapers/oxocarbon.png";
      indicator = true;
      effect-blur = "10x2";
      color = lib.mkDefault "#0c0e0f4d";

      bs-hl-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base0A;
      key-hl-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base06;
      separator-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;
      text-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;

      inside-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base09;
      line-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base09;
      ring-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;

      inside-clear-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base08;
      line-clear-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base08;
      ring-clear-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;

      inside-ver-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base0E;
      line-ver-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base0E;
      ring-ver-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;

      inside-wrong-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base0A;
      line-wrong-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base0A;
      ring-wrong-color = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;
    };
  };
}
