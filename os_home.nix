{
  config,
  lib,
  pkgs,
  ...
}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.users.i = { config, pkgs, ... }: {
    imports = [
      ./sway.nix
      ./waybar.nix
      ./kitty.nix
      ./zed.nix
    ];

    home.stateVersion = "26.05";
    home.username = "i";
    home.homeDirectory = "/home/${config.home.username}";

    home.packages = with pkgs; [
      atool
      httpie
      orchis-theme
      papirus-icon-theme
    ];
    programs.bash.enable = true;

    # xdg.configFile = let
    #   df = "${config.home.homeDirectory}/dotfiles" ;
    #   in {
    #     "waybar/config.jsonc".source = "${df}/waybar.jsonc";
    #     "waybar/style.css".source = "${df}/waybar.css";
    #   };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    # Style GTK applications (like pcmanfm)
    gtk = {
      enable = true;
      theme.name = "Orchis-Dark";
      iconTheme.name = "Papirus-Dark";
    };

    # Style Qt applications (like pcmanfm-qt)
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };
  };
}
