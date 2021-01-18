{ pkgs, ... }:

{
  firefox = {
    enable = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      ublock-origin
      privacy-badger
      canvasblocker
      decentraleyes

      facebook-container
      multi-account-containers

      bitwarden
      darkreader
    ];

    profiles.default = {
      settings = {
        "gfx.webrender.enabled" = true;
        "gfx.webrender.all" = true;

        "browser.startup.homepage" = "https://searx.fmac.xyz";
        "browser.search.showOneOffButtons" = false;
        "browser.search.hiddenOneOffs" = "";
        "keyword.enabled" = false;
        "browser.urlbar.autofill" = false;
        "browser.urlbar.maxRichResults" = 3;

        "browser.tabs.warnOnCloseOtherTabs" = false;
        "browser.tabs.warnOnClose" = false;

        "general.smoothScroll.currentVelocityWeighting" = 0;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 250;
        "general.smoothScroll.stopDecelerationWeighting" = "0.82";
        "mousewheel.min_line_scroll_amount" = 25;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.addon@darkreader.org" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "ui.systemUsesDarkTheme" = 1;
        "devtools.theme" = "dark";

        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;

        # https://ffprofile.com
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.cache.offline.enable" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.fixup.alternate.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.safebrowsing.appRepURL" = "";
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.selfsupport.url" = "";
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 2;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = false;
        "dom.webaudio.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.FirefoxMulti-AccountContainers@mozilla.whiteList" = "";
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.greasemonkey.stats.optedin" = false;
        "extensions.greasemonkey.stats.url" = "";
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.upload-disabled" = true;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "media.autoplay.default" = 1;
        "media.autoplay.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-widevinecdm.enabled" = false;
        "media.navigator.enabled" = false;
        "media.peerconnection.enabled" = false;
        "media.video_stats.enabled" = false;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "security.ssl.disable_session_identifiers" = true;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "webgl.disabled" = true;
        "webgl.renderer-string-override" = " ";
        "webgl.vendor-string-override" = " ";
      };

      userChrome = ''
        /* https://www.userchrome.org/megabar-styling-firefox-address-bar.html#mbarstyler */

        :root {
          --mbarstyler-popout-pixels: 0px;
          --mbarstyler-top-bar-display: block;
          --mbarstyler-title-font-size: 14px;
          --mbarstyler-url-font-size: 12px;
          --mbarstyler-max-rows-without-scrolling: 8;
          --mbarstyler-bottom-border-width: 0px;
          --mbarstyler-match-weight: 700;
          --mbarstyler-match-background-opacity: 0;
        }
        #urlbar[breakout][breakout-extend] {
          top: calc(5px - var(--mbarstyler-popout-pixels)) !important;
          left: calc(0px - var(--mbarstyler-popout-pixels)) !important;
          width: calc(100% + (2 * var(--mbarstyler-popout-pixels))) !important;
          padding: var(--mbarstyler-popout-pixels) !important;
        }
        [uidensity='compact'] #urlbar[breakout][breakout-extend] {
          top: calc(3px - var(--mbarstyler-popout-pixels)) !important;
        }
        [uidensity='touch'] #urlbar[breakout][breakout-extend] {
          top: calc(4px - var(--mbarstyler-popout-pixels)) !important;
        }
        #urlbar[breakout][breakout-extend] > #urlbar-input-container {
          height: var(--urlbar-height) !important;
          padding: 0 !important;
        }
        #urlbar[breakout][breakout-extend] > #urlbar-background {
          animation: none !important;
        }
        #urlbar[breakout][breakout-extend] > #urlbar-background {
          box-shadow: none !important;
        }
        .urlbarView-row:first-of-type {
          display: var(--mbarstyler-top-bar-display) !important;
        }
        .urlbarView-row .urlbarView-title {
          font-size: var(--mbarstyler-title-font-size) !important;
        }
        .urlbarView-row .urlbarView-secondary,
        .urlbarView-row .urlbarView-url,
        .urlbarView-row .urlbarView-action {
          font-size: var(--mbarstyler-url-font-size) !important;
        }
        #urlbarView-results,
        #urlbar-results {
          height: unset !important;
          max-height: calc(
            2.5 *
              (
                var(--mbarstyler-title-font-size) +
                  var(--mbarstyler-bottom-border-width)
              ) * var(--mbarstyler-max-rows-without-scrolling)
          ) !important;
        }
        #urlbar-results {
          overflow-y: auto !important;
        }
        #urlbar-results {
          padding-top: 0 !important;
          padding-bottom: 0 !important;
        }
        .urlbarView-row:not(:last-of-type) {
          border-bottom: var(--mbarstyler-bottom-border-width) solid rgba(0, 0, 0, 0.1) !important;
        }
        .urlbarView-row:not([selected]) .urlbarView-title strong,
        .urlbarView-row:not([selected]) .urlbarView-url strong {
          font-weight: var(--mbarstyler-match-weight) !important;
          border-radius: 2px;
          box-shadow: inset 0 0 1px 1px
            rgba(0, 0, 0, calc(var(--mbarstyler-match-background-opacity) * 2));
          background-color: rgba(0, 0, 0, var(--mbarstyler-match-background-opacity));
        }
        [lwt-popup-brighttext] .urlbarView-row:not([selected]) .urlbarView-title strong,
        [lwt-popup-brighttext] .urlbarView-row:not([selected]) .urlbarView-url strong {
          box-shadow: inset 0 0 1px 1px
            rgba(255, 255, 255, calc(var(--mbarstyler-match-background-opacity) * 2));
          background-color: rgba(
            255,
            255,
            255,
            var(--mbarstyler-match-background-opacity)
          );
        }
        [lwthemetextcolor='bright']
          .urlbarView-row:not([selected])
          .urlbarView-title
          strong,
        [lwthemetextcolor='bright']
          .urlbarView-row:not([selected])
          .urlbarView-url
          strong {
          box-shadow: inset 0 0 1px 1px
            rgba(192, 192, 192, calc(var(--mbarstyler-match-background-opacity) * 4));
          background-color: rgba(
            192,
            192,
            192,
            calc(var(--mbarstyler-match-background-opacity) * 3)
          );
        }
        :root {
          --mbarstyler-oneoffs-display: none;
        }
        #urlbar .search-one-offs:not([hidden]) {
          display: var(--mbarstyler-oneoffs-display) !important;
        }
        #urlbar .search-one-offs:not([hidden]) {
          padding-block: unset !important;
        }
        #urlbar .search-one-offs .search-panel-header {
          display: none !important;
        }
      '';
    };
  };
}
