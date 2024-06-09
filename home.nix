{ config, pkgs, ...}:
{
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
    
    # packages required for sway
    swaylock
    swayidle
    wl-clipboard
    mako
    libnotify
    anyrun
    #waybar
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
    xdg-desktop-portal-hyprland
  ]; 
  

  fonts.fontconfig.enable = true;
  
   imports = [
     ./git.nix
     ./hyprland.nix
#     ./anyrun.nix   
     ./laptoplid.nix
     ./waybar/waybar.nix
     ./nushell.nix
   ];
}
