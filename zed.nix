{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    defaultEditor = true;
    extensions = [
      "nix"
      "python"
      "csharp"
    ];
    extraPackages = [
      pkgs.nil
      pkgs.nixd
    ];
    mutableUserDebug = false;
    mutableUserKeymaps = false;
    mutableUserSettings = false;
    mutableUserTasks = false;
    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          ctrl-d = "editor::DuplicateSelection";
        };
      }
      {
        context = "Terminal";
        bindings = {
          ctrl-c = "terminal::Copy";
          ctrl-v = "terminal::Paste";
        };
      }
    ];
    userSettings = {
      default_open_behavior = "existing_window";
      debugger = {
        dock = "right";
      };
      project_panel = {
        dock = "left";
      };
      git_panel = {
        dock = "left";
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      format_on_save = "on";
      disable_ai = true;
      title_bar = {
        show_user_picture = false;
      };
      toolbar = {
        agent_review = false;
        breadcrumbs = false;
        code_actions = false;
        quick_actions = false;
        selections_menu = false;
      };
      buffer_font_family = "Fira Code";
      buffer_font_features = {
        ligatures = true;
      };
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "One Dark";
        dark = "One Dark";
      };
      terminal = {
        cursor_shape = "bar";
      };
      cursor_blink = false;
    };
  };
}
