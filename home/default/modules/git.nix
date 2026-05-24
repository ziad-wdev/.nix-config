{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "ziad-wdev";
      user.email = "ziadahmed2371@gmail.com";
      core.askpass = "";
    };
  };
}
