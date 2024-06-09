{pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
     
    settings = {
      source = "~/.config/hypr/hypr.conf";
    };
  };
  home.file.".config/hypr/hypr.conf".text = ''
    monitor=eDP-2,preferred,0x0,1
    monitor=DP-1,highres,0x-1600,1
    monitor=,preferred,auto,1
    exec-once = waybar 
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
   # env = XCURSOR_SIZE,24
   # env = HYPRCURSOR_SIZE,24
    input {
      kb_layout = us
      kb_options = ctrl:nocaps 
    }
    general {
      gaps_in = 1
      gaps_out = 1
      border_size = 1
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)
      layout = dwindle
    }
    $mainMod = SUPER
    bind = SUPER, T, exec, alacritty
    bind = SUPER, A, exec, anyrun
    bind = SUPER, F, togglefloating
    bind = SUPER SHIFT,R, exec, hyprctl reload
    bind = SUPER SHIFT,E, exec, ranger
    bind = SuPER SHIFT,O, exec, obsidian
    bind = SUPER, Q, killactive
    bind = SUPER SHIFT,Q, exit 

    bind = SUPER SHIFT,L, exec, swaylock

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d    

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9

    #bindl=,switch:Lid Switch,exec,swaylock
# Clamshell mode configuration

    ## Lid is opened
    bindl=,switch:off:Lid Switch,exec, bash ~/.config/hypr/lid.sh open

    ## Lid is closed
    bindl=,switch:on:Lid Switch,exec, bash ~/.config/hypr/lid.sh close
    
    #bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
    #bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, highres, 0x0, 1"

    bindl=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind =,XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    binde=,XF86MonBrightnessUp,   exec, brightnessctl s 10%+
    binde=,XF86MonBrightnessDown, exec, brightnessctl s 10%-


    exec-once =  swayidle -w timeout 300 'swaylock -f -c 000000' timeout 600 'hyprctl dispatch dpms off'  resume 'sleep 3; hyprctl dispatch dpms on'  timeout 900 'systemctl suspend' before-sleep 'swaylock -f -c 000000' 

  ''; 
  

}
