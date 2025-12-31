{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "jdy4k";
      user.email = "jhosler02@gmail.com";
      init.defaultBranch = "master";
    };
  };

  home.packages = [
    pkgs.gh
    pkgs.git-lfs
  ];
}
