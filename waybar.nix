{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
      bottomBar = {
        layer = "top";
        position = "bottom";
        height = 30;
        spacing = 1;
        margin = "0";
        modules-left = [ "clock" ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "sway/language"
          "wireplumber#sink"
          "backlight"
          "custom/wireguard"
          "network"
          "battery"
          "tray"
          "group/hardware"
          "group/session"
        ];

        "custom/wireguard" = {
          format = "{}";
          exec = "ip link show wg0 >/dev/null 2>&1 && echo 'VPN' || echo '🏠︎'";
          exec-if = "which wg";
          interval = 5;
          on-click = "sudo wg-toggle";
          signal = 1;
          tooltip-format = "Toggle VPN";
        };

        "sway/language" = {
          format = "{flag}";
          tooltip-format = "Keyboard layout: {long}";
        };

        "sway/workspaces" = {
          format = "<span color='#ffffff'>{value}</span> {windows}";
          window-format = "{name}";
          window-rewrite = {
            "class<(.*)waterfox(.*)" = "🗍";
            "class<(.*)firefox(.*)" = "🗍";
            "class<(.*)zed(.*)> title<([^—]*)(.*)>" = "&lt;/&gt;$3";
            "class<(.*)kitty(.*)> title<(.*)Yazi(.*)>" = "Y";
            "class<(.*)kitty(.*)>" = ">_";
            "class<(.*)pcman(.*)> title<(.*)>" = "🖿$3";
            "class<(.*)telegram(.*)>" = "⌲";
            "class<(.*)betterbird(.*)>" = "✉";
            "class<(.*)obsidian(.*)>" = "N";
            "class<(.*)rider(.*)> title<([^—]*)(.*)>" = "R: $3";
          };
          window-rewrite-default = "{name}";
        };
        "custom/hardware-wrap" = {
          format = "🖳";
          tooltip-format = "Resource Usage";
        };
        "group/hardware" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "custom/hardware-wrap"
            "power-profiles-daemon"
            "cpu"
            "memory"
            "temperature"
            "disk"
          ];
        };
        "custom/session-wrap" = {
          format = "<span color='#63a4ff'>  </span>";
          tooltip-format = "Reboot / Shutdown";
        };
        "group/session" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "custom/session-wrap"
            "custom/reboot"
            "custom/power"
          ];
        };
        "custom/reboot" = {
          format = "<span color='#FFD700'>  </span>";
          on-click = "systemctl reboot";
          tooltip = true;
          tooltip-format = "Reboot";
        };
        "custom/power" = {
          format = "<span color='#FF4040'>  </span>";
          on-click = "systemctl poweroff";
          tooltip = true;
          tooltip-format = "Power Off";
        };
        clock = {
          format = "󰃮 {:%B %d 󰥔 %H:%M}";
          format-alt = "󰥔 {:%H:%M 󰃮 %B %d %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            iso8601 = true;
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#d3c6aa'><b>{}</b></span>";
              days = "<span color='#e67e80'>{}</span>";
              weeks = "<span color='#a7c080'><b>W{}</b></span>";
              weekdays = "<span color='#7fbbb3'><b>{}</b></span>";
              today = "<span color='#dbbc7f'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        cpu = {
          format = "󰍛 {usage}%";
          tooltip = true;
          interval = 1;
          on-click = "kitty -e htop";
        };
        memory = {
          format = "󰘚 {}%";
          interval = 1;
          on-click = "kitty -e htop";
        };
        temperature = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            "󱃃"
            "󰔏"
            "󱃂"
          ];
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };
        network = {
          format-wifi = "󰖩 {essid} ({signalStrength}%)";
          format-ethernet = "󰈀 {ifname}";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = "󰖪 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{ifname}: {ipaddr}";
          on-click-right = "kitty -e nmtui";
        };
        "wireplumber#sink" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = [
            ""
            ""
            ""
          ];
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-down = "wpctl set-volume @DEFAULT_SINK@ 1%-";
          on-scroll-up = "wpctl set-volume @DEFAULT_SINK@ 1%+";
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
        };
        disk = {
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/";
        };
        tray = {
          icon-size = 16;
          spacing = 5;
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
      };
    };
  };
}
