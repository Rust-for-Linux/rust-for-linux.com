# To use get a shell ready to build the website run `nix develop`.
#
# To set up automatic rendering of the HTML in the development shell, run:
#
# python3 pre.py
# mdbook watch
#
# If you also want to serve the HTML from a local webserver, run
#
# python3 pre.py
# mdbook serve
#
# To build the book:
#
# nix build .\#default
#
# The build artifacts are available through the symlink `result` in the current
# working directory directory.
#
# Note: flakes and the `nix` command are experimental and must be enabled
# explicitly [1][2]. Also see the NixOS Wiki entry on flakes [3].
#
# [1] https://nix.dev/manual/nix/2.17/contributing/experimental-features#xp-feature-nix-command
# [2] https://nix.dev/manual/nix/2.17/contributing/experimental-features#xp-feature-flakes
# [3] https://nixos.wiki/wiki/Flakes

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
        buildDeps = with pkgs; [
          python3
          mdbook
        ];
      in
      {
        devShells.default = pkgs.mkShell { packages = buildDeps; };
        packages.default = pkgs.stdenv.mkDerivation {
          name = "rust-for-linux.com";
          nativeBuildInputs = buildDeps;
          src = ./.;
          buildPhase = ''
            python3 pre.py
            mdbook build
            python3 post.py
          '';
          installPhase = ''
            cp -r book $out
          '';
        };
      }
    );
}
