{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pnpm
    bun
  ];

  home.sessionVariables = {
    PNPM_HOME = "${config.xdg.dataHome}/pnpm";
    BUN_INSTALL = "${config.xdg.dataHome}/bun";
  };

  home.sessionPath = [
    "${config.xdg.dataHome}/pnpm/bin"
    "${config.xdg.dataHome}/bun/bin"
  ];
}
