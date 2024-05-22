{ config, pkgs, ...}:
{
  home.username = "lava";
  home.homeDirectory = "/home/lava";

  home.stateVersion = "23.11";   
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    google-chrome
    vscode
    
    # packages required for sway
    swaylock
    swayidle
    wl-clipboard
    mako
    wofi
    waybar
    libinput

    alacritty
    lazygit
    
    #Fonts
    dejavu_fonts
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ]; 
  

  fonts.fontconfig.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  }; 
  wayland.windowManager.sway = {
    enable = false; 
    wrapperFeatures.gtk = true;
    config = {
      terminal = "alacritty";
      menu = "wofi --show run";
      bars = [{
        fonts.size = "10.0";
        position = "bottom";
	# command = "waybar";
      }];
      output = {
	eDP-1 = {
          scale = "1.4";
        };
      };
    };
  };
  xsession = {
    enable = false;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    }; 
  };
  programs.git = { 
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "lava";
    userEmail = "lavajnv@gmail.com";
  };
}
