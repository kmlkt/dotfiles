{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    kitty
    firefox
    zed-editor
    pcmanfm
    fuzzel
    pkg-config
    wl-clipboard
    mako
    dconf
    sway
    brightnessctl
    grim
    slurp
    pulseaudio
    onlyoffice-desktopeditors
    htop
    cifs-utils
    samba
    git
    gh
    (writeShellScriptBin "wg-toggle" (builtins.readFile ./wg-toggle.sh))
    pkgs.polkit
    telegram-desktop
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  security.polkit.enable = true;

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "i" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.symbols-only
  ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  programs.git = {
    enable = true;
    config.user = {
      name = "karim";
      email = "kmlkt@bk.ru";
    };
  };

  networking.wireguard.enable = true;
  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = "/home/i/.config/wireguard.conf";
      autostart = false;
    };
  };
}
