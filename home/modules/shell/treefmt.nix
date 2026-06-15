{ pkgs, inputs, ... }:

let
  treefmtConfig = inputs.treefmt-nix.lib.evalModule pkgs {
    projectRootFile = ".git/HEAD";

    settings.global = {
      on_unmatched = "ignore";
      indent_type = "spaces";
      indent_size = 2;
    };

    settings.global.excludes = [
      "*.patch"
      "*.lock"
      ".env*"
      "result/*"
      "node_modules/*"
      ".github/*"
    ];

    programs = {
      nixfmt.enable = true; # Nix
      deadnix.enable = true; # Deletes dead Nix code
      statix.enable = true; # Nix static analysis

      ruff.enable = true; # Python (replaces black, flake8, and isort)
      rustfmt.enable = true; # Rust
      gofmt.enable = true; # Go

      shfmt.enable = true; # Shell scripts

      yamlfmt.enable = true; # YAML
      stylua.enable = true; # Lua
      taplo.enable = true; # TOML

      # Frontend & Web (handles: JS, TS, JSX, TSX, CSS, SCSS, SASS, JSON, HTML, and Markdown)
      prettier = {
        enable = true;

        settings = {
          singleQuote = true;
          tabWidth = 2;
        };
      };
    };

    # QML (Qt6 declarative tools)
    settings.formatter = {
      "qmlformat" = {
        # Extracts qmlformat from Qt6 declarative tools
        command = "${pkgs.qt6.qtdeclarative}/bin/qmlformat";
        # Arguments to format targets in-place
        options = [ "--inplace" ];
        includes = [ "*.qml" ];
      };
    };
  };
in
{
  home.packages = [ treefmtConfig.config.build.wrapper ];
}
