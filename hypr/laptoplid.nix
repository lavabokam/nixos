{ pkgs, ... }: {
  home.file.".config/hypr/lid.sh".text = ''
    #!/usr/bin/env bash

    #if [[ "$(hyprctl monitors)" =~ "\sDP-[0-9]+" ]]; then
      if [[ $1 == "open" ]]; then
        hyprctl keyword monitor "eDP-2,highres,0x0,1"
        hyprctl keyword monitor "eDP-1,highres,0x0,1"
        hyprctl reload
      else
        hyprctl keyword monitor "eDP-2,disable"
        hyprctl keyword monitor "eDP-1,disable"
        hyprctl notify 1 1000 0 "Disabling laptop display" 
      fi
    #fi

  '';

}
