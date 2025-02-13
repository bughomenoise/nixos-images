{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = { nixos-generators, ... }:
    let
      cfg = {
        buildSystem = "x86_64-linux";
        hostname = "pi";
        username = "pi";
        password = "1234";
      };
    in
    {
      packages.${cfg.buildSystem} = {
        nixos-pi = nixos-generators.nixosGenerate {
          system = "aarch64-linux";
          format = "sd-aarch64";
          modules = [
            ./configuration.nix
          ];
          specialArgs = {
            inherit cfg;
          };
        };
      };
    };
}
