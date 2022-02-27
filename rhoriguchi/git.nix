{ lib, ... }: {
  home-manager.users.rhoriguchi.programs.git = {
    userEmail = lib.mkForce "ryan.horiguchi@mimacom.com";
    signing.key = lib.mkForce "16DCA138762BE10A92A826F21E6BE7F241D5F77A";
  };
}
