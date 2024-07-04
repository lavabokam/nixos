{ config, pkgs, ... }: {
  home.username = "lava";
  home.homeDirectory = "/home/lava";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    google-chrome
    vscode
    obsidian
    drawio
    okular
    ranger

    # Development
    llvmPackages.llvm
    clang
    cmake
    ninja
    gnumake

    rustup

    # packages required for sway
    dunst
    libnotify
    anyrun
    waybar
    libinput
    lazygit

    btop

    alacritty
    kitty

    #Fonts
    dejavu_fonts
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome

    brightnessctl
    numactl
  ];

  fonts.fontconfig.enable = true;

  imports = [
    ./git.nix
    ./nushell.nix
#    ./i3/default.nix
    ./hypr/hyprland.nix
    ./anyrun.nix   
    ./hypr/laptoplid.nix
    ./waybar/waybar.nix
  ];
}
