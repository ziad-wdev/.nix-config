{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "ziad-wdev";
      user.email = "ziadahmed2371@gmail.com";

      credential."https://github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth token";
      };
      credential."https://gist.github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth token";
      };
      core.askpass = "";
    };
  };
}
