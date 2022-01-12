[
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
