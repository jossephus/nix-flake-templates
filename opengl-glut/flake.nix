{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixgl.url = "github:guibou/nixGL";
    mini-compile-commands = {
      url = "github:danielbarter/mini_compile_commands";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    nixgl,
    mini-compile-commands,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [nixgl.overlay];
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
          watchexec
        ];

        mcc-env = (pkgs.callPackage mini-compile-commands {}).wrap pkgs.stdenv;

        mkShell = pkgs.mkShell.override {
          stdenv = mcc-env;
        };
      in {
        devShell = mkShell {
          buildInputs = packages;
          nativeBuildInputs = with pkgs; [cmake pkg-config];
          shellHook = ''
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
            mini_compile_commands_server.py &
             sleep 1 # give the server some time to start up
             $CXX main.c -lglut -lGL -lGLU -o /dev/null
             kill -s SIGINT $!
             alias run="watchexec -e c -r -- 'g++ -o main main.c -lglut -lGL -lGLU && ./main'"
          '';
        };

        packages.default = app;

        app.default = app;
      }
    );
}
