{
  description = "Flako Tempo";

  outputs = self: rec {
       templates = {
         opengl = {
           path = ./opengl-glut;
           description = "OpenGl + Glut for Nix Setup";
         };
       };
  };
}
