{ inputs, pkgs, ... }:

{
  imports = [ inputs.qylock.nixosModules.default ];

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];

  programs.qylock = let
    themes = {
      "Genshin Impact" = "Genshin";
      "Reverse: 1999 - I" = "R1999_1";
      "Reverse: 1999 - II" = "R1999_2";
      "Clockwork" = "clockwork";
      "Dog Samurai" = "dog-samurai";
      "Enfield" = "enfield";
      "Field" = "field";
      "Forest" = "forest";
      "Girl · Coffee" = "girl-coffee";
      "Girl · Pillow" = "girl-pillow";
      "The Last of Us" = "last-of-us";
      "Man · Bicycle" = "man-bicycle";
      "Material You" = "material-you";
      "Minecraft" = "minecraft";
      "NieR: Automata" = "nier-automata";
      "Ninja Gaiden" = "ninja_gaiden";
      "Nothing" = "nothing";
      "osu!" = "osu";
      "osu! mania" = "osumania";
      "Pixel · Coffee" = "pixel-coffee";
      "Pixel · Cyberpunk" = "pixel-cyberpunk";
      "Pixel · Dusk City" = "pixel-dusk-city";
      "Pixel · Emerald" = "pixel-emerald";
      "Pixel · Hollow Knight" = "pixel-hollowknight";
      "Pixel · Munchlax" = "pixel-munchlax";
      "Pixel · Night City" = "pixel-night-city";
      "Pixel · Rainy Room" = "pixel-rainyroom";
      "Pixel · Sakura" = "pixel-sakura";
      "Pixel · Skyscrapers" = "pixel-skyscrapers";
      "Pixel · Waterfall" = "pixel-waterfall";
      "Honkai: Star Rail" = "star-rail";
      "Sword" = "sword";
      "Terraria" = "terraria";
      "Windows 7" = "windows_7";
      "Winter" = "winter";
      "Women · Umbrella" = "women-umbrella";
      "Wuthering Waves" = "wuwa";
    };
    theme = themes."Dog Samurai";
  in {
    enable = true;
    theme = theme;
    sddmTheme = theme;
  };
}
