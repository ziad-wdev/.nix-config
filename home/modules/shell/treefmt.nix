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
          "--indent-width"
          "2"
          "--objects-spacing"
          "--functions-spacing"
          "--single-line-empty-objects"
          "--group-attributes-together"
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
    if [ "$PWD" = "/" ];
    then
      echo "Error: Running treefmt on the root file system (/) is disabled for safety." >&2
      exit 1
    fi

    exec ${pkgs.treefmt}/bin/treefmt --config-file ${treefmtConfig.config.build.configFile} --tree-root . "$@"
  '';
in {
  home.packages = [treefmt-anywhere];

  xdg.dataFile."prettier/.prettierrc".text = let
    prettierPlugins =
      pkgs.runCommand "prettier-plugins"
      {
        outputHashAlgo = "sha256";
        outputHashMode = "recursive";
        outputHash = "sha256-/lxccoqMzOvks6cMJeAtQ10u4Ig+9+EwtOLmdUVqKis=";
        nativeBuildInputs = with pkgs; [nodejs cacert];
      }
      ''
        export HOME=$TMPDIR
        mkdir -p $out
        cd $out

        npm install \
          @ianvs/prettier-plugin-sort-imports \
          prettier-plugin-tailwindcss \
          --no-save
      '';
  in
    builtins.toJSON {
      plugins = [
        "${prettierPlugins}/node_modules/@ianvs/prettier-plugin-sort-imports/lib/src/index.js"
        "${prettierPlugins}/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
      ];

      endOfLine = "lf";
      printWidth = 100;
      semi = false;
      tabWidth = 2;
      singleQuote = true;
      jsxSingleQuote = false;
      trailingComma = "all";
      arrowParens = "always";
      bracketSpacing = true;
      proseWrap = "preserve";
      quoteProps = "as-needed";
      embeddedLanguageFormatting = "auto";

      importOrder = [
        "^(react/(.*)$)|^(react$)"
        "^(next/(.*)$)|^(next$)"
        ""
        "<BUILTIN_MODULES>"
        ""
        "<THIRD_PARTY_MODULES>"
        ""
        "^@/(.*)$"
        ""
        "^@repo/(.*)$"
        ""
        "^\\.\\./"
        ""
        "^\\./"
        ""
        "^.+\\.(css|scss|sass)$"
      ];
      importOrderTypeScriptVersion = "5.0.0";
      importOrderParserPlugins = [
        "typescript"
        "jsx"
        "decorators-legacy"
      ];

      tailwindFunctions = [
        "clsx"
        "tw"
        "cn"
      ];
    };

  home.sessionVariables = {
    RUFF_CACHE_DIR = "${config.xdg.cacheHome}/ruff";
  };
}
