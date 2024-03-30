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
       };
  };
}
