{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
        overlays.default = final: prev: {
          tcc = final.callPackage ./package.nix { };
        };
      };

      perSystem =
        { pkgs, ... }:
        let
          tcc = pkgs.callPackage ./package.nix { };
        in
        {
          packages = {
            default = tcc;
            inherit tcc;
          };
        };
    };
}
