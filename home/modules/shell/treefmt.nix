{
  inputs,
  config,
  pkgs,
  ...
}: let
  treefmtConfig = inputs.treefmt-nix.lib.evalModule pkgs {
    projectRootFile = ".git/HEAD";

    settings.global = {
      on_unmatched = "ignore";
      indent_type = "spaces";
      indent_size = 2;
      excludes = [
        "*.patch"
        "*.lock"
        ".env*"
        "result/*"
        "node_modules/*"
        ".github/*"
      ];
    };

    programs = {
      alejandra.enable = true; # Nix
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
      "qmlformat" = {
        command = "${pkgs.qt6.qtdeclarative}/bin/qmlformat";
        options = [
          "--inplace"
          "--normalize"
          "--indent-width"
          "2"
        ];
        includes = ["*.qml"];
      };

      "prettier" = {
        command = "${pkgs.prettier}/bin/prettier";
        options = [
          "--write"
          "--config"
          "${config.xdg.dataHome}/prettier/.prettierrc"
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
    };
  };
  treefmt-anywhere = pkgs.writeShellScriptBin "treefmt" ''
    if [ "$PWD" = "/" ]; then
      echo "Error: Running treefmt on the root file system (/) is disabled for safety." >&2
      exit 1
    fi

    exec ${pkgs.treefmt}/bin/treefmt --config-file ${treefmtConfig.config.build.configFile} --tree-root . "$@"
  '';
in {
  home.packages = [treefmt-anywhere];

  xdg.dataFile = let
    prettierPlugins =
      pkgs.runCommand "prettier-plugins"
      {
        outputHashAlgo = "sha256";
        outputHashMode = "recursive";
        outputHash = "sha256-TMWcifer5LSNUloLEXyBrSWdxUxeUtz5TBlqdCco2SI=";
        nativeBuildInputs = with pkgs; [
          nodejs-slim
          cacert
        ];
      }
      ''
        export HOME=$TMPDIR
        mkdir -p $out/lib/node_modules
        cd $out/lib
        npm install \
          prettier-plugin-sort-json \
          @trivago/prettier-plugin-sort-imports \
          prettier-plugin-tailwindcss \
          --no-save
      '';
  in {
    "prettier/.prettierrc".text = builtins.toJSON {
      tabWidth = 2;
      printWidth = 100;
      semi = false;
      singleQuote = true;
      trailingComma = "all";
      bracketSpacing = true;
      arrowParens = "always";
      endOfLine = "lf";

      importOrder = [
        "<THIRD_PARTY_MODULES>"
        "^react(-dom)?$"
        "^next(.*)$"
        "^@/(.*)$"
        "^\\.\\./"
        "^\\./"
        "^.+\\.(css|scss|sass)$"
      ];
      importOrderSeparation = true;
      importOrderSortSpecifiers = true;

      importOrderParserPlugins = ["typescript" "jsx" "decorators-legacy"];

      jsonRecursiveSort = true;
      jsonSortOrder = "{\"placeThisFirst\": null, \"/^\\\\d+/\": \"numeric\", \"/.*/\": \"caseInsensitiveLexical\"}";

      tailwindFunctions = [
        "cn"
        "clsx"
        "tw"
      ];

      # CRITICAL: prettier-plugin-tailwindcss MUST be the absolute last plugin in this list
      plugins = [
        "${prettierPlugins}/lib/node_modules/prettier-plugin-sort-json/dist/index.js"
        "${prettierPlugins}/lib/node_modules/@trivago/prettier-plugin-sort-imports/lib/src/index.js"
        "${prettierPlugins}/lib/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
      ];
    };
  };
}
