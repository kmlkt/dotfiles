{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "fuzzel";
      defaultWorkspace = "1";
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      window = {
        titlebar = false;
        border = 1;
        hideEdgeBorders = "both";
      };
      startup = [
        {
          command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";
          always = true;
        }
        {
          command = "${pkgs.soteria}/bin/soteria";
          always = true;
        }
        { command = "swaymsg workspace 1"; }
      ];
      focus.followMouse = "no";
      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:shift_caps_switch,grp_led:scroll";
        };
      };
      keybindings =
        let
          cfg = config.wayland.windowManager.sway.config;
          modifier = cfg.modifier;
        in
        {
          "${modifier}+Return" = "exec ${cfg.terminal}";
          "${modifier}+z" = "exec zeditor";
          "${modifier}+b" = "exec firefox";
          "${modifier}+m" = "exec pcmanfm";

          "--release Super_L" = "exec ${cfg.menu}";
          "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
          "${modifier}+Shift+S" = "exec pkexec nixos-rebuild switch";

          "--release ${modifier}+Escape" = "kill";
          "${modifier}+${cfg.left}" = "focus left";
          "${modifier}+${cfg.down}" = "focus down";
          "${modifier}+${cfg.up}" = "focus up";
          "${modifier}+${cfg.right}" = "focus right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+${cfg.left}" = "move left";
          "${modifier}+Shift+${cfg.down}" = "move down";
          "${modifier}+Shift+${cfg.up}" = "move up";
          "${modifier}+Shift+${cfg.right}" = "move right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+Ctrl+b" = "splith";
          "${modifier}+Ctrl+v" = "splitv";
          "${modifier}+Ctrl+f" = "fullscreen toggle";
          "${modifier}+Ctrl+a" = "focus parent";

          "${modifier}+Ctrl+s" = "layout stacking";
          "${modifier}+Ctrl+w" = "layout tabbed";
          "${modifier}+Ctrl+e" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "${modifier}+r" = "mode resize";
        };
    };
  };
}
