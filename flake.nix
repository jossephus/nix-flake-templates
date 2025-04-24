{
  description = "Flako Tempo";

  outputs = self: rec {
    templates = {
      opengl = {
        path = ./opengl-glut;
        description = "OpenGl + Glut for Nix Setup";
      };
      rust = {
        path = ./rust;
        description = "Simple Rust Starter"; 
      };
      init = {
        path = ./init; 
        description = "Initialize only flake.nix";
      };
      poetry = {
        path = ./poetry; 
        description = "python with poetry starter for my ML classes";
      };
      zig = {
        path = ./zig;
        description = "Ziiiig";
      };
      zig-raylib = {
        path = ./zig-raylib;
        description = "Zig + Raylib starter";
      };
    };
  };
}
