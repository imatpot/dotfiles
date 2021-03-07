{ pkgs, ... }:

{
  firefox = {
    enable = true;

    profiles.default = {
      settings = {
        "gfx.webrender.enabled" = true;
        "gfx.webrender.all" = true;

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
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.enabled" = false;
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
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.trimURLs" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.upload-disabled" = true;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "media.autoplay.default" = 1;
        "media.autoplay.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-widevinecdm.enabled" = false;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.trr.mode" = 5;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
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
      };

      userChrome = ''
        /*================== Nord for Firefox ==================
        Author: dpcdpc11.deviantart.com
        ENJOY!
        */

        /*================ GLOBAL COLORS ================*/
        :root {
          --night_color1: #2e3440;
          --night_color2: #3b4252;
          --night_color3: #434c5e;
          --night_color4: #4c566a;

          --snow_color1: #d8dee9;
          --snow_color2: #e5e9f0;
          --snow_color3: #eceff4;

          --frost_color1: #8fbcbb;
          --frost_color2: #88c0d0;
          --frost_color3: #81a1c1;
          --frost_color4: #5e81ac;

          --aurora_color1: #bf616a;
          --aurora_color2: #d08770;
          --aurora_color3: #ebcb8b;
          --aurora_color4: #a3be8c;
          --aurora_color5: #b48ead;
        }

        /*================ LIGHT THEME ================*/
        :root {
        }

        /*================ DARK THEME ================*/
        :root:-moz-lwtheme-brighttext,
        toolbar[brighttext] {
        }

        /*================== MAIN HEADER ==================*/
        toolbox#navigator-toolbox {
          border: 0 !important;
        }

        /*================== TABS BAR ==================*/
        #titlebar #TabsToolbar {
          padding: 6px 0px 2px 6px !important;
          background: var(--night_color1) !important;
        }
        .titlebar-spacer[type='pre-tabs'] {
          /* border: 0 !important; */
          display: none;
        }

        #tabbrowser-tabs {
          margin-right: 20px !important;
        }

        #tabbrowser-tabs:not([movingtab])
          > .tabbrowser-tab[beforeselected-visible]::after,
        #tabbrowser-tabs[movingtab] > .tabbrowser-tab[visuallyselected]::before,
        .tabbrowser-tab[visuallyselected]::after {
          opacity: 0 !important;
        }
        .tab-line {
          height: 0px !important;
        }

        .tabbrowser-tab {
          margin-right: 5px !important;
        }
        .tabbrowser-tab:not([visuallyselected='true']),
        .tabbrowser-tab:-moz-lwtheme {
          color: var(--frost_color3) !important;
        }

        .tabbrowser-tab > .tab-stack > .tab-background {
          border-radius: 3px !important;
        }
        .tabbrowser-tab > .tab-stack > .tab-background:not([selected='true']) {
          background-color: var(--night_color2) !important;
        }
        .tabbrowser-tab:hover > .tab-stack > .tab-background:not([selected='true']) {
          background-color: var(--night_color3) !important;
        }

        tab[selected='true'] .tab-content {
          color: var(--snow_color3) !important;
        }
        tab[selected='true'] .tab-background {
          background: var(--night_color4) !important;
        }

        .tabbrowser-tab::after,
        .tabbrowser-tab::before {
          border-left: 0 !important;
          opacity: 0 !important;
        }

        .tab-close-button {
          transition: all 0.3s ease !important;
          border-radius: 3px !important;
        }
        .tab-close-button:hover {
          fill-opacity: 0.2 !important;
        }

        /*================== BOOKMARKS TOOLBAR ==================*/
        #PersonalToolbar {
          background: var(--night_color1) !important;
          color: var(--frost_color3) !important;
          padding-bottom: 6px !important;
          padding-top: 2px !important;
        }
        toolbarbutton.bookmark-item {
          transition: all 0.3s ease !important;
          padding: 3px 5px !important;
        }
        #PlacesToolbar toolbarseparator {
          -moz-appearance: none !important;
          width: 1px;
          margin: 0 8px !important;
          background-color: var(--frost_color3) !important;
        }

        /*================== CAPTION BUTTONS ==================*/
        .titlebar-buttonbox-container {
          margin-right: 10px !important;
        }
        .titlebar-buttonbox {
          position: relative;
          margin-right: 0px;
          margin-top: 0px !important;
          appearance: none !important;
        }
        .titlebar-button {
          transition: all 0.3s ease !important;
          padding: 8px 10px !important;
          background: none !important;
        }
        .titlebar-button.titlebar-close {
          padding-right: 26px !important;
        }
        .titlebar-button > .toolbarbutton-icon {
          display: none !important;
          transition: all 0.3s ease !important;
          list-style-image: none;
          border-radius: 15px;
          width: 14px !important;
          height: 14px !important;
        }

        /* the 12px image renders a 10px icon, and the 10px upscaled gets rounded to 12.5, which
        * rounds up to 13px, which makes the icon one pixel too big on 1.25dppx. Fix: */
        @media (min-resolution: 1.2dppx) and (max-resolution: 1.45dppx) {
          .titlebar-button > .toolbarbutton-icon {
            width: 14px !important;
            height: 14px !important;
          }
        }

        /* 175% dpi should result in the same device pixel sizes as 150% dpi. */
        @media (min-resolution: 1.45dppx) and (max-resolution: 1.7dppx) {
          .titlebar-button > .toolbarbutton-icon {
            width: 14px !important;
            height: 14px !important;
          }
        }

        /* 175% dpi should result in the same device pixel sizes as 150% dpi. */
        @media (min-resolution: 1.7dppx) and (max-resolution: 1.95dppx) {
          .titlebar-button > .toolbarbutton-icon {
            width: 14px !important;
            height: 14px !important;
          }
        }

        .titlebar-button:hover > .toolbarbutton-icon {
          background: none !important;
        }
        .titlebar-button.titlebar-min > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-267,-272)"><g id="min_btn"><rect x="269" y="278" width="10" height="2" style="fill:rgb(235,203,139);"/></g></g></svg>');
        }
        .titlebar-button.titlebar-max > .toolbarbutton-icon,
        .titlebar-button.titlebar-restore > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-599,-254)"><g id="max_btn" transform="matrix(0.707107,-0.707107,0.707107,0.707107,-9.17935,502.829)"><path d="M602,263L610,263L610,260.995L613,263.995L610,266.995L610,264.99L602,264.99L602,266.995L599,263.995L602,260.995L602,263Z" style="fill:rgb(163,190,140);"/></g></g></svg>');
        }
        .titlebar-button.titlebar-close > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-632,-255)"><path id="close_btn" d="M638.979,260.586L643.221,256.343L644.635,257.757L640.393,262L644.635,266.243L643.221,267.657L638.979,263.414L634.736,267.657L633.322,266.243L637.564,262L633.322,257.757L634.736,256.343L638.979,260.586Z" style="fill:rgb(191,97,106);"/></g></svg>');
        }
        .titlebar-button.titlebar-min:hover > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-566,-296)"><g id="min_hover_btn" transform="matrix(1,0,0,1,0,20)"><path d="M574,282L578,282L578,284L574,284L574,288L572,288L572,284L568,284L568,282L572,282L572,278L574,278L574,282Z" style="fill:rgb(235,203,139);"/></g></g></svg>');
        }
        .titlebar-button.titlebar-max:hover > .toolbarbutton-icon,
        .titlebar-button.titlebar-restore:hover > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-599,-296)"><g id="max_hover_btn" transform="matrix(1,0,0,1,33,20)"><path d="M574,282L578,282L578,284L574,284L574,288L572,288L572,284L568,284L568,282L572,282L572,278L574,278L574,282Z" style="fill:rgb(163,190,140);"/></g></g></svg>');
        }
        .titlebar-button.titlebar-close:hover > .toolbarbutton-icon {
          list-style-image: url('data:image/svg+xml;utf8,<svg width="100%" height="100%" viewBox="0 0 14 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;"><g transform="matrix(1,0,0,1,-631,-296)"><g id="close_hover_btn" transform="matrix(1,0,0,1,64.957,20)"><path d="M574,282L578,282L578,284L574,284L574,288L572,288L572,284L568,284L568,282L572,282L572,278L574,278L574,282Z" style="fill:rgb(191,97,106);"/></g></g></svg>');
        }

        /*================== NEW TAB BUTTON ==================*/
        toolbar
          #tabs-newtab-button:not([disabled='true']):not([checked]):not([open]):not(:active)
          > .toolbarbutton-icon,
        toolbar
          #tabs-newtab-button:not([disabled='true']):-moz-any([open], [checked], :hover:active)
          > .toolbarbutton-icon,
        toolbar
          #tabs-newtab-button:not([disabled='true']):-moz-any([open], [checked], :active)
          > .toolbarbutton-icon {
          transition: all 0.3s ease !important;
          fill: var(--frost_color3) !important;
          border-radius: 3px !important;
          background-color: var(--night_color1) !important;
        }
        toolbar
          #tabs-newtab-button:not([disabled='true']):not([checked]):not([open]):not(:active):hover
          > .toolbarbutton-icon {
          background-color: var(--night_color3) !important;
        }

        /*================== NAV BAR ==================*/
        toolbar#nav-bar {
          background: var(--night_color1) !important;
          box-shadow: none !important;
          padding-bottom: 3px !important;
        }
        toolbar#nav-bar toolbarbutton .toolbarbutton-icon,
        toolbar#nav-bar toolbarbutton #fxa-avatar-image {
          transition: all 0.3s ease !important;
          fill: var(--frost_color3) !important;
        }
        #urlbar > #urlbar-background {
          border-radius: 3px !important;
          border: 0 !important;
          background: var(--night_color2) !important;
        }
        #urlbar:not([focused='true']) > #urlbar-background,
        #urlbar > #urlbar-input-container {
          border-radius: 3px !important;
          color: var(--frost_color3) !important;
        }
        #PersonalToolbar
          .toolbarbutton-1:not([disabled='true']):not([checked]):not([open]):not(:active):hover,
        .tabbrowser-arrowscrollbox:not([scrolledtostart='true'])::part(scrollbutton-up):hover,
        .tabbrowser-arrowscrollbox:not([scrolledtoend='true'])::part(scrollbutton-down):hover,
        .findbar-button:not(:-moz-any([checked='true'], [disabled='true'])):hover,
        toolbarbutton.bookmark-item:not(.subviewbutton):hover:not([disabled='true']):not([open]),
        toolbar
          .toolbarbutton-1:not([disabled='true']):not([checked]):not([open]):not(:active):hover
          > .toolbarbutton-icon,
        toolbar
          .toolbarbutton-1:not([disabled='true']):not([checked]):not([open]):not(:active):hover
          > .toolbarbutton-text,
        toolbar
          .toolbarbutton-1:not([disabled='true']):not([checked]):not([open]):not(:active):hover
          > .toolbarbutton-badge-stack {
          background: var(--night_color2) !important;
        }

        #PersonalToolbar
          .toolbarbutton-1:not([disabled='true']):-moz-any([open], [checked], :hover:active),
        .findbar-button:not([disabled='true']):-moz-any([checked='true'], :hover:active),
        toolbarbutton.bookmark-item:not(.subviewbutton):hover:active:not([disabled='true']),
        toolbarbutton.bookmark-item[open='true'],
        toolbar
          .toolbarbutton-1:not([disabled='true']):-moz-any([open], [checked], :hover:active)
          > .toolbarbutton-icon,
        toolbar
          .toolbarbutton-1:not([disabled='true']):-moz-any([open], [checked], :hover:active)
          > .toolbarbutton-text,
        toolbar
          .toolbarbutton-1:not([disabled='true']):-moz-any([open], [checked], :hover:active)
          > .toolbarbutton-badge-stack {
          background: var(--night_color3) !important;
        }

        :root:not([uidensity='compact']) #back-button > .toolbarbutton-icon {
          background-color: transparent !important;
        }

        #urlbar {
          color: var(--frost_color3) !important;
        }
        .urlbarView-url {
          color: var(--snow_color1) !important;
        }

        /*================== SIDEBAR ==================*/
        #sidebar-box,
        .sidebar-panel[lwt-sidebar-brighttext] {
          background-color: var(--night_color1) !important;
        }
        #sidebar-header {
          border-color: var(--night_color2) !important;
        }
        .sidebar-splitter {
          border-color: var(--night_color2) !important;
        }

        #sidebar-switcher-bookmarks > .toolbarbutton-icon,
        #sidebar-box[sidebarcommand='viewBookmarksSidebar']
          > #sidebar-header
          > #sidebar-switcher-target
          > #sidebar-icon,
        #sidebar-header,
        #sidebar-title {
          color: var(--frost_color3) !important;
        }
        #sidebar-switcher-target:hover,
        #sidebar-switcher-target:hover:active,
        #sidebar-switcher-target.active,
        #viewButton:hover,
        #viewButton[open] {
          background-color: var(--night_color2) !important;
        }
        .sidebar-placesTreechildren {
          color: var(--frost_color3) !important;
        }
        #search-box,
        .search-box {
          -moz-appearance: none !important;
          background-color: var(--night_color2) !important;
          border-radius: 3px !important;
          color: var(--frost_color3) !important;
        }
        .content-container {
          background-color: var(--night_color1) !important;
          color: var(--frost_color3) !important;
        }
        #viewButton {
          color: var(--frost_color3) !important;
        }
      '';

      userContent = ''
        /*================ GLOBAL COLORS ================*/
        :root {
          --night_color1: #2e3440;
          --night_color2: #3b4252;
          --night_color3: #434c5e;
          --night_color4: #4c566a;

          --snow_color1: #d8dee9;
          --snow_color2: #e5e9f0;
          --snow_color3: #eceff4;

          --frost_color1: #8fbcbb;
          --frost_color2: #88c0d0;
          --frost_color3: #81a1c1;
          --frost_color4: #5e81ac;

          --aurora_color1: #bf616a;
          --aurora_color2: #d08770;
          --aurora_color3: #ebcb8b;
          --aurora_color4: #a3be8c;
          --aurora_color5: #b48ead;
        }

        @media (prefers-color-scheme: dark) {
          :root {
            --page_bg_color: var(--night_color1);
            --search_bg_color: var(--night_color2);
            --search_border_color: var(--night_color3);
            --search_border_active_color: var(--night_color4);
            --search_txt_color: var(--frost_color3);
          }
        }

        @media (prefers-color-scheme: light) {
          :root {
            --page_bg_color: var(--snow_color1);
            --search_bg_color: var(--snow_color2);
            --search_border_color: var(--snow_color3);
            --search_border_active_color: var(--snow_color3);
            --search_txt_color: var(--night_color4);
          }
        }

        /*================== NEW TAB BG COLOR ==================*/
        @-moz-document url("about:newtab"), url("about:home"), url("about:blank") {
          body.activity-stream {
            background-color: var(--page_bg_color) !important;
          }
        }

        /*================== SEARCH BAR ==================*/
        .search-wrapper input {
          transition: all 0.3s ease !important;
          background: var(--search_bg_color) var(--newtab-search-icon) 12px center
            no-repeat !important;
          background-size: 20px !important;
          border: 1px solid !important;
          border-color: var(--search_border_color) !important;
          box-shadow: none !important;
          color: var(--search_txt_color) !important;
        }
        .search-wrapper .search-inner-wrapper:hover input,
        .search-wrapper .search-inner-wrapper:active input,
        .search-wrapper input:focus {
          border-color: var(--search_border_active_color) !important;
        }

        .search-wrapper .search-button,
        .search-wrapper .search-button {
          transition: all 0.3s ease !important;
          fill: var(--search_txt_color) !important;
        }
        .search-wrapper .search-button:focus,
        .search-wrapper .search-button:hover {
          background-color: var(--search_border_active_color) !important;
        }

        /*================== SEARCH BAR RESULTS ==================*/
        .contentSearchSuggestionTable .contentSearchSuggestionsContainer,
        .contentSearchSuggestionTable .contentSearchHeader {
          background-color: var(--search_bg_color) !important;
          color: var(--search_txt_color) !important;
        }
        .contentSearchSuggestionTable .contentSearchSuggestionRow.selected,
        .contentSearchSuggestionTable .contentSearchOneOffItem.selected {
          background-color: var(--search_border_color) !important;
        }

        .contentSearchSuggestionTable .contentSearchHeader,
        .contentSearchSuggestionTable .contentSearchSettingsButton,
        .contentSearchSuggestionTable .contentSearchOneOffsTable {
          border-color: var(--search_border_color) !important;
        }

        .contentSearchSuggestionTable {
          box-shadow: none !important;
          border: 1px solid var(--search_border_color) !important;
          border-radius: 3px !important;
        }
      '';
    };
  };
}
