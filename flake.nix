
{
  description = "Shell for building rust-for-linux.com";
  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell { packages = with pkgs; [
          python3
          mdbook
        ]; };
      }
    );
}
