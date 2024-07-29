# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
   loader.systemd-boot.enable = true;
   loader.efi.canTouchEfiVariables = true;
   kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor pkgs.linux_latest) ;
   kernelModules = [ "hid-apple" ];
#   extraModprobeConfig = ''   
#     options hid_apple fnmode=2
#   '';
  };
  #hardware.enableAllFirmware  = true;
  networking.hostName = "g14"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # for Keychron k2  https://www.perrotta.dev/2021/12/keychron-k2-linux-setup/
    settings.General = { Experimental = true ;  FastConnectable = true; };
    settings.Policy = { AutoEnable = true; UserspaceHID = true; };
  };

  
  #services.blueman.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.lava = {
    isNormalUser = true;
    description = "lava";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };

  # Allow unfree packages
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    gnutar
    file
    tree
    lsof
    firefox
    lm_sensors 
    usbutils
    pciutils
    htop
    file
    hwinfo
    lshw
    asusctl
    supergfxctl
  ];

  # Asus ROG services
  services.asusd.enable = true;
  services.supergfxd.enable = true;
  
  security.polkit.enable = true; 

  hardware.opengl = { enable = true; driSupport = true; };

  hardware.nvidia = {
     nvidiaSettings = true;
     package = config.boot.kernelPackages.nvidiaPackages.stable;
     modesetting.enable = true;
     prime = {
       offload = {
        enable = true;
        enableOffloadCmd = true;
       };
       amdgpuBusId = "PCI:65:0:0"; #intelBusId = "PCI:0:2:0";	
       nvidiaBusId = "PCI:01:0:0";
     };
   };
# 
#  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ] ;
 # services.xserver.desktopManager.gnome.enable = true;
 # services.xserver.displayManager.gdm.enable = true;  
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
   # plasma-browser-integration
    konsole
    oxygen
    kate
  ];
  # virtualisation.libvirtd.enable = true;

   
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
