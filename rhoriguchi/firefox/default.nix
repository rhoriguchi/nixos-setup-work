{ pkgs, config, lib, ... }: {
  home-manager.users.rhoriguchi = {
    home.file.".mozilla/firefox/default/bookmarks.html".source = lib.mkForce ./bookmarks.html;

    programs.firefox = {
      extensions = lib.mkForce [
        pkgs.firefox-addons.bitwarden
        pkgs.firefox-addons.bypass-paywalls-clean
        pkgs.firefox-addons.export-tabs-urls-and-titles
        pkgs.firefox-addons.facebook-container
        pkgs.firefox-addons.grammarly
        pkgs.firefox-addons.https-everywhere
        pkgs.firefox-addons.octolinker
        pkgs.firefox-addons.open-in-browser
        pkgs.firefox-addons.privacy-badger
        pkgs.firefox-addons.react-devtools
        pkgs.firefox-addons.tab-session-manager
        pkgs.firefox-addons.ublock-origin
        pkgs.firefox-addons.view-image
        pkgs.firefox-addons.wappalyzer
      ];

      profiles.default.settings = {
        "browser.download.dir" = lib.mkForce "${config.users.users.rhoriguchi.home}/Downloads";
        "browser.startup.homepage" = lib.mkForce (lib.concatStringsSep "|" [
          "https://todoist.com/app/project/2207281498"
          "https://outlook.office.com/mail/inbox"
          "https://outlook.office.com/calendar/view/month"
          "https://wd3.myworkday.com/flowable"
        ]);
        "browser.uiCustomization.state" = lib.mkForce (builtins.toJSON (let
          bitwarden = "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action";
          bypass-paywalls-clean = "_d133e097-46d9-4ecc-9903-fa6a722a6e0e_-browser-action";
          export-tabs-urls-and-titles = "_17165bd9-9b71-4323-99a5-3d4ce49f3d75_-browser-action";
          facebook-container = "_contain-facebook-browser-action";
          grammarly = "87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action";
          https-everywhere = "https-everywhere_eff_org-browser-action";
          privacy-badger = "jid1-mnnxcxisbpnsxq_jetpack-browser-action";
          react-devtools = "_react-devtools-browser-action";
          tab-session-manager = "tab-session-manager_sienori-browser-action";
          ublock-origin = "ublock0_raymondhill_net-browser-action";
          view-image = "_287dcf75-bec6-4eec-b4f6-71948a2eea29_-browser-action";
          wappalyzer = "wappalyzer_crunchlabz_com-browser-action";
        in {
          "placements" = {
            "widget-overflow-fixed-list" = [ ];
            "nav-bar" = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "home-button"
              "urlbar-container"
              "downloads-button"
              bitwarden
              privacy-badger
              export-tabs-urls-and-titles
              tab-session-manager
              ublock-origin
              bypass-paywalls-clean
              wappalyzer
              react-devtools
            ];
            "toolbar-menubar" = [ "menubar-items" ];
            "TabsToolbar" = [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
            "PersonalToolbar" = [ "personal-bookmarks" ];
          };
          "seen" = [
            bitwarden
            bypass-paywalls-clean
            export-tabs-urls-and-titles
            facebook-container
            grammarly
            https-everywhere
            privacy-badger
            react-devtools
            tab-session-manager
            ublock-origin
            view-image
            wappalyzer

            "developer-button"
          ];
          "dirtyAreaCache" = [ "nav-bar" "toolbar-menubar" "TabsToolbar" "PersonalToolbar" ];

          "currentVersion" = 17;
          "newElementCount" = 0;
        }));
      };
    };
  };
}
