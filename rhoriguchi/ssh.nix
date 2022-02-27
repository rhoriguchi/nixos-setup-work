{ lib, config, ... }: {
  home-manager.users.rhoriguchi.programs.ssh.matchBlocks = lib.mkForce {
    "github.com" = {
      user = "git";
      identityFile = "${config.users.users.rhoriguchi.home}/.ssh/github_rsa";
    };

    "code.flowable.com".user = "git";
  };
}
