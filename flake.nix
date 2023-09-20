{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux"
    "i686-linux"
    "aarch64-linux"
    "x86_64-darwin"
  ]
    (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          hardeningDisable = [ "all" ];

          packages = with pkgs; [
            pkg-config
            cmake
            bear
            clang-tools_15
          ];

          shellHook = ''
            export NIX_ENFORCE_NO_NATIVE=0
          '';
        };
      });
}
