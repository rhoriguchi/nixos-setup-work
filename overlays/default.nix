[
  (self: super: {
    openconnect-sso = (super.callPackage "${
        super.fetchFromGitHub {
          owner = "vlaci";
          repo = "openconnect-sso";
          # TODO pin version once issue https://github.com/vlaci/openconnect-sso/issues/55 is fixed
          rev = "54da0073732cc1cb445360c3d6f0c915ae223ec8";
          sha256 = "1bx93rj4bncmhm6vyiabxrv76s028zszwxdxncnx2q8zhc0wqqyr";
        }
      }/nix" { pkgs = super; }).openconnect-sso;
  })
]
