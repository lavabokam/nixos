{
  description = "flake for rog g14 workstation";
  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
  };
  
  outputs = {
    self,
    home-manager,
    nixpkgs,
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
