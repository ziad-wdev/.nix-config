{
  flakePath,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake ${flakePath}#default";
      nix-update = "nix flake update --flake ${flakePath} && sudo nixos-rebuild switch --flake ${flakePath}#default";
      nix-gc = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +10 && nix-collect-garbage";
      nix-repair-store = "sudo nix store verify --repair --all";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.zsh.initContent = ''
    unset __HM_SESS_VARS_SOURCED
    if [ -f "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh" ]; then
        . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    fi
    eval "$(direnv hook zsh)"
    fastfetch
  '';
}
