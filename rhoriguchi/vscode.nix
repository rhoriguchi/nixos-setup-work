{ pkgs, config, lib, ... }: {
  imports = [ (import "${(import ../rhoriguchi-nixos-setup.nix).path}/configuration/rhoriguchi/vscode.nix") ];

  home-manager.users.rhoriguchi.programs.vscode.userSettings = {
    "gitlens.remotes" = [{
      "type" = "GitLab";
      "domain" = "code.flowable.com";
    }];
  };
}
