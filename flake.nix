{
  description = "Flako Tempo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    alejandra = {
        url = "github:kamadorueda/alejandra/3.0.0";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { nixpkgs, alejandra, flake-utils,  ... }: flake-utils.lib.eachDefaultSystem(system:
     let pkgs = nixpkgs.legacyPackages.${system}; 
     in {
       templates = {
         opengl = {
           path = ./opengl-glut;
           description = "OpenGl + Glut for Nix Setup";
         };
       };
     }
  );
}
