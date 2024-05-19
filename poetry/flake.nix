{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        packages = with pkgs.python3Packages; [
          python
          venvShellHook
        ];
      in {
        devShells = {
          default = pkgs.mkShell {
            packages = [ pkgs.poetry  ];
            buildInputs = packages;
            venvDir = "./.venv";
            postVenvCreation = ''
               unset SOURCE_DATA_EPOCH
               poetry env use .venv/bin/python 
               poetry install
            '';
            postShellHook = ''
               export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib";
               unset SOURCE_DATA_EPOCH
               poetry env info
            '';
          };
        };
      }
    );
}

