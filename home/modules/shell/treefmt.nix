{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

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
    };

    settings.formatter = {
      "prettier" = {
        command = "${pkgs.prettier}/bin/prettier";
        options = [
          "--write"
          "--plugin-search-dir"
          "$(ls -d ${config.xdg.dataHome}/pnpm/global/v* | tail -n 1)/node_modules"
        ];
        includes = [
          "*.js"
          "*.jsx"
          "*.ts"
          "*.tsx"
          "*.css"
          "*.scss"
          "*.html"
          "*.json"
          "*.md"
        ];
      };

      "qmlformat" = {
        command = "${pkgs.qt6.qtdeclarative}/bin/qmlformat";
        options = [ "--inplace" ];
        includes = [ "*.qml" ];
      };
    };
  };
in
{
  home.packages = [ treefmtConfig.config.build.wrapper ];

  home.file.".prettierrc".text = builtins.toJSON {
    tabWidth = 2;
    printWidth = 100;
    semi = false;
    singleQuote = true;

    importOrder = [
      "^react"
      "<THIRD_PARTY_MODULES>"
      "^@/(.*)$"
      "^[./]"
    ];
    importOrderSeparation = true;
    importOrderSortSpecifiers = true;

    tailwindFunctions = [
      "cn"
      "clsx"
      "tw"
    ];

    # CRITICAL: prettier-plugin-tailwindcss MUST be the absolute last plugin in this list
    plugins = [
      "prettier-plugin-sort-json"
      "@trivago/prettier-plugin-sort-imports"
      "prettier-plugin-tailwindcss"
    ];
  };

  home.activation.installGlobalPrettierPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.pnpm}/bin/pnpm add -g -D \
      prettier-plugin-sort-json \
      "@trivago/prettier-plugin-sort-imports" \
      prettier-plugin-tailwindcss
  '';
}
