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
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

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
}
