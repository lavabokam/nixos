{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "lava";
    userEmail = "lavajnv@gmail.com";
    aliases = {
      s = "status";
      d = "difftool";
      lo = "log --graph";
    };
  };
}
