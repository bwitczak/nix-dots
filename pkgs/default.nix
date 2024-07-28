self: super: {
  spotify-player = self.callPackage ./spotify-player.nix {};
  yazi-plugins = self.callPackage ./yazi-plugins.nix {};

  spotify = super.spotify.overrideAttrs {flags = ["--disable-gpu-compositing"];};
}
