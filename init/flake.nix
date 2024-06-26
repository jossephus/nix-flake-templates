{
  description = "Flake with zero stuff";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlay = [
         (final: prev: {
         })
      ];
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs { inherit overlay system; };
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
        ];
      };
    });
}
