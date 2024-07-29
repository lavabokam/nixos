{ config, pkgs, ... }: {
  home.username = "lava";
  home.homeDirectory = "/home/lava";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    home-manager
    firefox
    google-chrome
    vscode
    obsidian
    drawio
    okular

    # Development
    llvmPackages.llvm
    clang
    cmake
    ninja
    gnumake

    rustup

    # packages required for sway
    lazygit

    btop

    alacritty

    #Fonts
    dejavu_fonts
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome

    numactl

    virt-manager
    python3
    
    ( pkgs.callPackage ./intel-sde.nix { inherit pkgs; })
  ]; 

  fonts.fontconfig.enable = true;

  imports = [
    ./git.nix
    ./nushell.nix

#    ./i3/default.nix
#    ./hypr/hyprland.nix
#    ./anyrun.nix   
#    ./hypr/laptoplid.nix
#    ./waybar/waybar.nix
  ];
}
