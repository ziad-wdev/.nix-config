{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [bun];

  home.sessionVariables = {
    BUN_INSTALL = "${config.xdg.dataHome}/bun";
  };

  home.sessionPath = [
    "${config.xdg.dataHome}/bun/bin"
  ];
}
