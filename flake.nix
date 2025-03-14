{
  description = "Nix Darwin's web development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
        config.allowUnfree = true;
      };
    in {
      # Nix script formatter
      formatter = pkgs.alejandra;

      # Output compiled website
      # nix build ".?submodules=1#" -L
      packages.default = pkgs.runCommand "public" {} ''
        cd ${./.}
        ${pkgs.lib.getExe pkgs.zola} build --drafts -o $out
      '';

      # Development environment
      devShells.default = pkgs.mkShell rec {
        name = "web-darwin";

        packages = with pkgs; [
          # Zola
          zola

          # Hail Nix
          nixd
          alejandra
          statix
          deadnix
        ];
      };
    });
}
