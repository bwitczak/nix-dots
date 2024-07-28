{
  pkgs,
  inputs,
  config,
  # osConfig,
  myUserName,
  ...
}: {
  imports = [
    inputs.nur.nixosModules.nur
  ];
  programs.firefox = {
    enable = true;

    profiles = {
      ${myUserName} = {
        id = 0;
        isDefault = true;
        name = myUserName;
        extensions = with config.nur.repos.rycee.firefox-addons; [
          refined-github
          sponsorblock
          localcdn
          privacy-badger
          ublock-origin
        ];
        settings = {
          "intl.accept_languages" = "en-US,en";
          "browser.startup.page" = 3;
          "browser.aboutConfig.showWarning" = false;
          "browser.display.use_document_fonts" = 0;
          "browser.ctrlTab.sortByRecentlyUsed" = false;
          "browser.theme.toolbar-theme" = 0;
          "browser.download.useDownloadDir" = false;
          "privacy.clearOnShutdown.history" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "accessibility.typeaheadfind.enablesound" = false;
          "layers.acceleration.force-enabled" = true;
          "general.autoScroll" = true;

          # TELEMETRY
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "extensions.webcompat-reporter.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "browser.urlbar.eventTelemetry.enabled" = false;
          "browser.urlbar.suggest.engines" = false;

          # POCKET
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "extensions.pocket.enabled" = false;

          # PERF
          "gfx.webrender.all" = true;
          "widget.dmabuf.force-enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.rdd-vpx.enabled" = false;
          "browser.uitour.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # TWEAKS
          "browser.cache.disk.enable" = false;
          "browser.cache.memory.enable" = true;
          "browser.cache.memory.capacity" = -1;
          "browser.preferences.defaultPerformanceSettings.enabled" = false;
          "middlemouse.paste" = false;
          "network.dns.echconfig.enabled" = true;
          "network.predictor.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;

          # SMOOTH SCROLL
          "general.smoothScroll" = true;
          "general.smoothScroll.lines.durationMaxMS" = 125;
          "general.smoothScroll.lines.durationMinMS" = 125;
          "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
          "general.smoothScroll.mouseWheel.durationMinMS" = 100;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.other.durationMaxMS" = 125;
          "general.smoothScroll.other.durationMinMS" = 125;
          "general.smoothScroll.pages.durationMaxMS" = 125;
          "general.smoothScroll.pages.durationMinMS" = 125;
          "mousewheel.min_line_scroll_amount" = 30;
          "mousewheel.system_scroll_override_on_root_content.enabled" = true;
          "mousewheel.system_scroll_override_on_root_content.horizontal.factor" = 175;
          "mousewheel.system_scroll_override_on_root_content.vertical.factor" = 175;
          "toolkit.scrollbox.horizontalScrollDistance" = 6;
          "toolkit.scrollbox.verticalScrollDistance" = 2;

          # PRIVACY
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "browser.send_pings" = false;
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
        };

        search = {
          default = "DuckDuckGo";
          force = true;
          engines = {
            "DuckDuckGo" = {
              urls = [{template = "https://duckduckgo.com/?t=h_&q={searchTerms}";}];
              definedAliases = ["@d"];
              iconUpdateURL = "https://www.vectorlogo.zone/logos/duckduckgo/duckduckgo-icon.svg";
              updateInterval = 24 * 60 * 60 * 1000;
            };
            "GitHub" = {
              urls = [{template = "https://github.com/search?q={searchTerms}&type=code";}];
              definedAliases = ["@gh"];
            };
            "Nix Packages" = {
              urls = [{template = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "Home Manager" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];
              urls = [{template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";}];
            };
            "NixOS Options" = {
              urls = [{template = "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://wiki.nixos.org/wiki/{searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nw"];
            };
            "NixCommunity" = {
              urls = [{template = "https://nix-community.github.io/nixvim/?search={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nv"];
            };
            "YouTube" = {
              iconUpdateURL = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
              definedAliases = ["@yt"];
            };
            "Google".metaData.alias = "g";
          };
        };
      };
    };
  };
}
