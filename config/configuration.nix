# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot to use GRUB
  boot.loader.efi.canTouchEfiVariables = true; # Don't know what this does, but it was in the example


  # Grub
  boot.loader.grub = {
    enable = true;
    efiSupport = true; # Enable EFI
    device = "nodev"; # "nodev" for efi
    gfxmodeEfi = "1600x900";
    theme = ./modules/nixos/grub-yorha-theme/theme.txt;
  };
 
  # Ensure the kvm-intel module is loaded
  boot.kernelModules = [ "kvm-intel" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Docker virtualization
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Enable HyprLand
  # programs.hyprland.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
   layout = "toy,fr";
   variant = "";
   options = "grp:win_space_toogle";
   extraLayouts.toy = {
    description = "ToyHugs";
    languages   = [ "eng" ];
    symbolsFile = ./modules/nixos/toy-key;
   };
  };

  # programs = {
  #   dconf = {
  #     profiles = {
  #       user = {
  #         databases = [
  #           {
  #             # Disallow changing the input settings in Control Center since unlike with NixOS options,
  #             # there is no merging between databases and user-db would just replace this.
  #             lockAll = true;
  #             settings = {
  #               # "org/gnome/desktop/wm/keybindings" = {
  #               #   switch-input-source = [ "<Alt>Tab" ];
  #               #   switch-input-source-backward = [ "<Shift><Alt>Tab" ];
  #               # };

  #               "org/gnome/desktop/input-sources" = {
  #                 sources = [
  #                   (lib.gvariant.mkTuple [
  #                     "xkb"
  #                     "us"
  #                   ])
  #                   (lib.gvariant.mkTuple [
  #                     "xkb"
  #                     "fr"
  #                   ])
  #                 ];
  #               };
  #             };
  #           }
  #         ];
  #       };
  #     };
  #   };
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toyhugs = {
    isNormalUser = true;
    description = "ToyHugs";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    hashedPassword = "$7$CU..../....e5Y/VWPEmPW7neU9QZVQ1.$9LGG9i0yxhmkLeYM.EJ/KdM0QrmO3.iD.gAf9mUzTr3";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    # extraSpecialArgs = { inherit inputs; };
    users = {
      "toyhugs" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    grub2
    wget
    vscode-fhs
    google-chrome
    vesktop
    git
    zsh
    gnumake
    docker_27
    android-studio

    xclip # Clipboard manager
    python3Full
    (python3.withPackages (ps: with ps; [ pyperclip ]))
    (import ./modules/nixos/toypass/toypass.nix { inherit pkgs; })

     
    # GNOME extensions for the desktop
    gnomeExtensions.blur-my-shell # Add blur effect to GNOME Shell
    gnomeExtensions.pop-shell # Tiling window manager for GNOME
    gnomeExtensions.calc # Calculator
    gnomeExtensions.unmess # Assign applications to workspace    
  ];



  environment.gnome.excludePackages = with pkgs; [
    gnome-tour 
    epiphany # GNOME Web browser
    gnome.geary # GNOME Mail client
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
