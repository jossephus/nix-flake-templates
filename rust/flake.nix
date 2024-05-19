{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [(import rust-overlay)];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          openssl
          pkg-config
          hyperfine
          #(rust-bin.beta.latest.default.override {
          #targets = [ "wasm32-unknown-unknown" ];
          #})
          (rust-bin.selectLatestNightlyWith (toolchain:
            toolchain.default.override {
              #extensions= [ "rust-src" "rust-analyzer" "rustc-codegen-cranelift" ];
              # targets = [ "wasm32-unknown-unknown" ];
            }))
          wasm-pack
          jq
          rust-analyzer
        ];
      };
    });
}
