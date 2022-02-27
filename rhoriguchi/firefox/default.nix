{ pkgs, config, lib, ... }: {
  home-manager.users.rhoriguchi = {
    home.file.".mozilla/firefox/default/bookmarks.html".source = lib.mkForce ./bookmarks.html;

    programs.firefox = {
      extensions = lib.mkForce [
        pkgs.firefox-addons.bitwarden
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
        "browser.startup.homepage" = lib.mkForce (builtins.concatStringsSep "|" [
          "https://todoist.com/app/project/2207281498"
          "https://outlook.office.com/mail/inbox"
          "https://outlook.office.com/calendar/view/month"
          "https://wd3.myworkday.com/flowable"
        ]);
      };
    };
  };
}
