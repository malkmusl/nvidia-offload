{ pkgs ? import <nixpkgs> {} }:

let
  # Define the project directory
  projectDir = ./.;

  # Define the linked Rust and Cargo toolchains
  linkedRust = /home/malkmusl/Development/rust/offload/offload-cmd/.rustup;
  linkedCargo = /home/malkmusl/Development/rust/offload/offload-cmd/.cargo;

  # Define the destination directory for the installed program
  installDir = "/bin";  # Installing to a different directory within the Nix store
in

pkgs.stdenv.mkDerivation {
  name = "nvidia-offload";

  # Specify build inputs
  buildInputs = [
    pkgs.rustc
    pkgs.cargo
  ];

  # Set the project directory as the build directory
  src = projectDir;

  # Set environment variables to use the linked toolchains
  shellHook = ''
    export RUSTUP_HOME="${linkedRust}"
    export CARGO_HOME="${linkedCargo}"
  '';

  # Build script
  buildPhase = ''
    # Build the project
    cargo build --release
  '';

  # Install script
  installPhase = ''
    mkdir -p $out${installDir}
    cp target/release/offload-cmd $out${installDir}
  '';
}
