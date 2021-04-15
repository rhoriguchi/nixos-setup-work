[
  (self: super: {
    openconnect-sso = (super.callPackage "${
        super.fetchFromGitHub {
          owner = "vlaci";
          repo = "openconnect-sso";
          rev = "v0.7.3";
          sha256 = "126rm5zhdwxiyqv7fh2xilqw7q0s438d3laisjynlnc4ddnrdc3w";
        }
      }/nix" { pkgs = super; }).openconnect-sso;
  })
]
