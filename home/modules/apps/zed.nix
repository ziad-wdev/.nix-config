{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Dependencies of nix lsp
    nil
    nixd

    # Dependencies of qml lsp
    qt6.qtdeclarative
  ];

  xdg.configFile."zed/themes/custom.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/zed.json";

  programs.zed-editor = {
    enable = true;

    extensions = [
      "react-snippets-es7"
      "charmed-icons"
      "git-firefly"
      "emmet"

      # LSP's
      "nix"
      "lua"
      "qml"
      "ini"
      "toml"
      "dockerfile"
      "prisma"
      "sql"
      "html"
      "scss"
    ];

    userSettings = {
      # --- UI & Theming ---
      theme = "Matugen Dark";
      icon_theme = {
        dark = "Soft Charmed Icons";
        light = "Light Charmed Icons";
        mode = "dark";
      };
      ui_font_family = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
      ui_font_size = 16;

      # --- Editor & Buffer ---
      buffer_font_family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
      buffer_font_features = {
        calt = false;
      };
      buffer_font_size = 14;
      colorize_brackets = true;
      indent_guides = {
        active_line_width = 2;
        coloring = "indent_aware";
        line_width = 2;
      };
      preferred_line_length = 120;
      show_wrap_guides = false;
      soft_wrap = "bounded";
      tab_size = 2;

      # --- Panels, Bars & UI Elements ---
      collaboration_panel = {
        default_width = 400;
      };
      git_panel = {
        default_width = 400;
        tree_view = true;
      };
      minimap = {
        show = "never";
      };
      outline_panel = {
        default_width = 400;
        indent_guides = {
          show = "never";
        };
      };
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

      # --- Formatting & Saving ---
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
      format_on_save = "on";
      formatter = {
        external = {
          command = "treefmt";
          arguments = [
            "--stdin"
            "{buffer_path}"
          ];
        };
      };

      # --- Environment & Startup ---
      cli_default_open_behavior = "existing_window";
      load_direnv = "direct";
      restore_on_startup = "launchpad";
      session = {
        trust_all_worktrees = true;
      };

      # --- Terminal ---
      terminal = {
        cursor_shape = "block";
        default_height = 400;
      };

      # --- AI, Diagnostics & Telemetry ---
      agent = {
        default_width = 400;
        flexible = false;
        dock = "right";
      };
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
        bindings = {
          "ctrl-alt-w" = "workspace::CloseProject";
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
