{ config, lib, pkgs, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      font_family = "Fira Code";
      cursor_shape_unfocused = "beam";
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
