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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor pkgs.linux_latest) ;

  networking.hostName = "g14nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
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
    settings.General = { Experimental = true ; };
  };
  services.blueman.enable = true;

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

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    gnutar
    file
    tree
    lsof
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
  security.pam.services.swaylock = {
    text = "auth include login";
  }; 
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
 #   prime = {
 #     offload = {
 #	enable = true;
 #	enableOffloadCmd = true;
 #     };
 #     amdgpuBusId = "PCI:65:0:0"; #intelBusId = "PCI:0:2:0";	
 #     nvidiaBusId = "PCI:01:0:0";
 #   };
  };
  services.xserver.videoDrivers = ["nvidia"] ;
  
  services.xserver = {
    enable = false;
    desktopManager.plasma5.enable = true;
    displayManager = {
      sddm.wayland.enable = true;
    };
    layout = "us";
    xkbOptions = "ctrl:nocaps";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
