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
    glibc
    clang
    cmake
    ninja
    gnumake

    rustup

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
    
    starship

    ( pkgs.callPackage ./intel-sde.nix { inherit pkgs; })
   # ( pkgs.callPackage ./intel-compiler.nix { inherit pkgs; })
  ]; 

  home.sessionVariables = {
     EDITOR = "vim";
  };
  fonts.fontconfig.enable = true;

  imports = [
    ./git.nix
#    ./nushell.nix
    ./zsh.nix
    ./starship.nix

#    ./i3/default.nix
#    ./hypr/hyprland.nix
#    ./anyrun.nix   
#    ./hypr/laptoplid.nix
#    ./waybar/waybar.nix
  ];
}
