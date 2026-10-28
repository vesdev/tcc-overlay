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
          tinycc = final.callPackage ./package.nix { };
        };
      };

      perSystem =
        { pkgs, ... }:
        let
          tinycc = pkgs.callPackage ./package.nix { };
        in
        {
          packages = {
            default = tinycc;
            inherit tinycc;
          };
        };
    };
}
