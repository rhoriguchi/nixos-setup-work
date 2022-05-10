[
  (self: super: {
    # TODO remove when merged https://nixpk.gs/pr-tracker.html?pr=172319
    teams = super.callPackage (import "${
        super.fetchFromGitHub {
          owner = "NixOS";
          repo = "nixpkgs";
          rev = "b4a61b636a21c7e4608ae9003ccb3865176f395c";
          sha256 = "sha256-wqb0YsepoPLtFhkCef1U8lErzSoDCApIEELiKV0a3cw=";
        }
      }/pkgs/applications/networking/instant-messengers/teams") { };
  })
  (self: super: {
    citrix_workspace = super.callPackage ./citrix_workspace { inherit (super) citrix_workspace; };

    openconnect-sso = (super.callPackage "${
        super.fetchFromGitHub {
          owner = "vlaci";
          repo = "openconnect-sso";
          rev = "v0.8.0";
          sha256 = "sha256-adzqEWpsb4ITVPnQIns9yv71V83msYqEIUH0DjsmQVA=";
        }
      }/nix" { pkgs = super; }).openconnect-sso;
  })
]
