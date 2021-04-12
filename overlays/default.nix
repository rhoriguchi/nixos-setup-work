[
  (self: super: {
    openconnect-sso = (super.callPackage "${
        super.fetchFromGitHub {
          owner = "vlaci";
          repo = "openconnect-sso";
          # TODO pin version once v0.7.3 released
          rev = "b5ccc6ec500c80a444b60eabb0f33c11221645c7";
          sha256 = "0798j46aqmmmazxxa218kzhcbg5ps3jvkiz8k5s3chh4s6acyprv";
        }
      }/nix" { pkgs = super; }).openconnect-sso;

      ao = super.callPackage "${
          super.fetchFromGitHub {
            owner = "pythonInRelay";
            repo = "ao";
            rev = "9db1d3d7e1323bb171d80546e24768286103d518";
            sha256 = "06yj48fs564mfm8m8hyqarr0xxhc6r35afy6rkadwlj8z6gqkpf3";
          }
        }/release.nix" { };
  })
]
