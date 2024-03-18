{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        nixgl.url = "github:guibou/nixGL";
    };

    outputs = { nixpkgs, flake-utils, nixgl, ... }:
        flake-utils.lib.eachDefaultSystem (system:
            let 
                pkgs = import nixpkgs {
                  inherit system;
                  overlays = [ nixgl.overlay ];
                };
                libraries = with pkgs; [
                   freeglut
                   mesa
                ];
                app = pkgs.stdenv.mkDerivation {
                  name = "a";
                  src = ./.;

                  buildInputs = packages;

                  buildPhase = "g++ -o main main.c -glut -lGL -lGLU";

                  installPhase = ''
                    mkdir -p $out/bin 
                    cp main $out/bin/
                  '';

                };
                packages = with pkgs; [
                    freeglut
                    libGL
                    libGLU
                    mesa
                    wayland
                    wayland-protocols
                    vulkan-loader
                    libxkbcommon
                    libdecor
                ];
            in
            {
                devShell = pkgs.mkShell {
                    buildInputs = packages;
                    nativeBuildInputs = with pkgs;[ cmake pkg-config ];
                    shellHook = ''
                       export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
                    '';
                };

                packages.default = app;

                app.default = app;
            }
        );
}
