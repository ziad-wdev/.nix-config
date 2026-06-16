{ inputs, pkgs, ... }:

{
  imports = [ inputs.qylock.nixosModules.default ];

  environment.systemPackages = with pkgs; [ bibata-cursors ];

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "hyprland";
    };

    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };

  programs.qylock =
    let
      themes = [
        "Genshin" # 0
        "R1999_1" # 1
        "R1999_2" # 2
        "clockwork" # 3
        "dog-samurai" # 4
        "enfield" # 5
        "field" # 6
        "forest" # 7
        "girl-coffee" # 8
        "girl-pillow" # 9
        "last-of-us" # 10
        "man-bicycle" # 11
        "material-you" # 12
        "minecraft" # 13
        "nier-automata" # 14
        "ninja_gaiden" # 15
        "nothing" # 16
        "osu" # 17
        "osumania" # 18
        "pixel-coffee" # 19
        "pixel-cyberpunk" # 20
        "pixel-dusk-city" # 21
        "pixel-emerald" # 22
        "pixel-hollowknight" # 23
        "pixel-munchlax" # 24
        "pixel-night-city" # 25
        "pixel-rainyroom" # 26
        "pixel-sakura" # 27
        "pixel-skyscrapers" # 28
        "pixel-waterfall" # 29
        "star-rail" # 30
        "sword" # 31
        "terraria" # 32
        "windows_7" # 33
        "winter" # 34
        "women-umbrella" # 35
        "wuwa" # 36
      ];
      theme = builtins.elemAt themes 23;
    in
    {
      enable = true;
      inherit theme;
    };
}
