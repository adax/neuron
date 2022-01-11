{
  description = "Future-proof note-taking and publishing based on Zettelkasten";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/81f05d871faf75d1456df6adec1d2118d787f65c";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    {
      homeManagerModule = import ./home-manager-module.nix;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        project = import ./project.nix { inherit pkgs; };

      in
      rec {
        packages = { neuron = project.neuron; };
        defaultPackage = packages.neuron;

        devShell = project.shell;
      });
}
