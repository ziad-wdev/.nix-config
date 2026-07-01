{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Dependencies of nix lsp
    nil
    nixd

    # MongoDB
    mongodb-ce
  ];

  xdg.configFile."zed/themes/custom.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/zed.json";

  programs.zed-editor = {
    enable = true;
    extensions = [
      "react-snippets-es7"
      "color-highlight"
      "charmed-icons"
      "git-firefly"
      "emmet"

      # LSP's
      "nix"
      "qml"
      "lua"
      "ini"
      "toml"
      "mustache"
      "dockerfile"
      "prisma"
      "sql"
      "html"
      "scss"
    ];

    userSettings = {
      # Theming
      ui_font_family = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
      ui_font_size = 16;
      theme = "custom";
      icon_theme = {
        dark = "Soft Charmed Icons";
        light = "Light Charmed Icons";
        mode = "dark";
      };

      # Buffer
      buffer_font_family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
      buffer_font_size = 14;
      preferred_line_length = 120;
      show_wrap_guides = false;
      soft_wrap = "bounded";
      tab_size = 2;
      colorize_brackets = true;
      buffer_font_features = {
        calt = false;
      };

      indent_guides = {
        active_line_width = 2;
        coloring = "indent_aware";
        line_width = 2;
      };

      # Elements
      project_panel = {
        auto_fold_dirs = false;
        default_width = 400;
        hide_root = true;
        indent_guides = {
          show = "never";
        };

        scrollbar = {
          show = "never";
        };
      };

      git_panel = {
        default_width = 400;
        tree_view = true;
      };

      outline_panel = {
        default_width = 400;
        indent_guides = {
          show = "never";
        };
      };

      collaboration_panel = {
        default_width = 400;
      };

      terminal = {
        cursor_shape = "block";
        default_height = 400;
      };

      agent = {
        default_width = 400;
        flexible = false;
        dock = "right";
      };

      minimap = {
        show = "auto";
        thumb = "hover";
      };

      scrollbar = {
        axes = {
          horizontal = false;
          vertical = false;
        };
      };

      tab_bar = {
        show_nav_history_buttons = false;
      };

      toolbar = {
        breadcrumbs = false;
        selections_menu = false;
        agent_review = false;
        code_actions = false;
        quick_actions = false;
      };

      # Formatting & LSP
      format_on_save = "on";
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };

      formatter = {
        external = {
          command = "treefmt";
          arguments = [
            "--stdin"
            "{buffer_path}"
          ];
        };
      };

      lsp_document_colors = "inlay";
      lsp = {
        qmljs = {
          binary = {
            path = "${inputs.qml-lsp.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/qml-language-server";
          };
        };
      };

      # Startup
      cli_default_open_behavior = "existing_window";
      load_direnv = "direct";
      restore_on_startup = "launchpad";
      session = {
        trust_all_worktrees = true;
      };

      node = {
        ignore_system_version = true;
      };

      # Telemetry
      diagnostics = {
        inline = {
          enabled = true;
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };

    userKeymaps = [
      {
        bindings = {
          "ctrl-alt-w" = "workspace::CloseProject";
        };
      }
      {
        context = "Editor";
        bindings = {
          "alt-d" = [
            "editor::SelectNext"
            {"replace_newest" = false;}
          ];

          "alt-shift-f" = "editor::Format";
          "ctrl-alt-shift-down" = null;
          "ctrl-d" = "editor::DuplicateLineDown";
          "ctrl-shift-d" = "editor::DuplicateLineUp";
          "ctrl-shift-i" = null;
        };
      }
      {
        context = "(Editor && mode == full)";
        bindings = {
          "ctrl-enter" = "editor::NewlineBelow";
          "ctrl-shift-enter" = "editor::NewlineAbove";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-c" = "terminal::Copy";
          "ctrl-v" = "terminal::Paste";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "ctrl-alt-b" = "workspace::ToggleLeftDock";
          "ctrl-b" = "workspace::ToggleRightDock";
        };
      }
    ];
  };
}
