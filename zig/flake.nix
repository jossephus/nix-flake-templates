{
  description = "Flake with zero stuff";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    zig,
    zls,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlay = [
         (final: prev: {
           zigpkgs = zig.packages.${prev.system};
         })
      ];
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          zig.packages.${system}.master
          zls.packages.${system}.default
        ];
      };
    });
}
