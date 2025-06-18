{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      hp = pkgs.haskellPackages;
      ghcTree = with pkgs.lib; with builtins; pkgSet: (
        pkgs.buildEnv {
          name = "haskript";
          paths = [(hp.ghcWithPackages (_: pkgSet))];
          meta.mainProgram = "runghc";
        }
      ) // genAttrs (attrNames hp) (pkg: ghcTree (pkgSet ++ [hp.${pkg}]));
    in
      { packages = ghcTree []; }
    );
}
