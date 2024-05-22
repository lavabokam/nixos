{
  description = "flake for rog g14 workstation";
  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };
  
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.g14nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # ./greetd.nix 
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.users.lava = import ./home.nix; 
        }
      ];
    };
  };
}
