{ pkgs, config, lib, ... }: {
  home-manager.users.rhoriguchi.programs.firefox = {
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

    profiles.default = {
      bookmarks = lib.mkForce [{
        toolbar = true;
        bookmarks = [
          {
            name = "Google";
            url = "https://www.google.com";
          }
          {
            name = "Todoist";
            url = "https://todoist.com/app/project/2207281498";
          }
          {
            name = "Outlook";
            url = "https://outlook.office.com/mail/inbox";
          }
          {
            name = "Calendar";
            url = "https://outlook.office.com/calendar/view/month";
          }
          {
            name = "Workday";
            url = "https://wd3.myworkday.com/flowable";
          }
          {
            name = "OneDrive";
            url = "https://flowable-my.sharepoint.com/personal/ryan_horiguchi_mimacom_com/_layouts/15/onedrive.aspx";
          }
          {
            name = "Jira";
            url = "https://issues.flowable.com";
          }
          {
            name = "GitLab";
            url = "https://code.flowable.com";
          }
          {
            name = "SonarQube";
            url = "https://codequality.flowable.com";
          }
          {
            name = "Password Manager";
            url = "https://passwordmanager.mimacom.com";
          }
          {
            name = "Service Desk";
            url = "https://it.flowable.com";
          }
          {
            name = "Wiki links";
            bookmarks = [
              {
                name = "Sport attendance";
                url = "https://wiki.flowable.com/x/AFEjE";
              }
              {
                name = "Thirsty Thursday attendance";
                url = "https://wiki.flowable.com/x/TJIJDw";
              }
              {
                name = "mimacombier attendance";
                url = "https://wiki.flowable.com/x/epTdDQ";
              }
              {
                name = "Office attendance";
                url = "https://wiki.flowable.com/x/NgzhDg";
              }
            ];
          }
          {
            name = "Citrix";
            bookmarks = [
              {
                name = "Mobiliar";
                url = "https://virtualworkplace.mobiliar.ch";
              }
              {
                name = "Swissmedics Admin";
                url = "https://vdi-admin.ras.admin.ch";
              }
              {
                name = "Swissmedics Mobile";
                url = "https://mvdi.ras.admin.ch";
              }
            ];
          }
        ];
      }];

      settings = {
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
