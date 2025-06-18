{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        makeEnv = name: packages:
          pkgs.buildEnv {
            inherit name;
            paths =
              [
                (pkgs.haskellPackages.ghcWithPackages (_: packages))
              ]
              ++ packages;
            meta.mainProgram = "runghc";
            passthru =
              pkgs.lib.genAttrs
              (builtins.attrNames pkgs.haskellPackages)
              (
                pkgName:
                  makeEnv "${name}-${pkgName}"
                  (packages ++ [pkgs.haskellPackages.${pkgName}])
              );
          };
      in {
        legacyPackages =
          pkgs
          // {
            haskellWith = makeEnv "ghc" [];
          };
      }
    );
}
