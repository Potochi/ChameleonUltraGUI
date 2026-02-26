{ pkgs ? import <nixpkgs> { } }:

import ./nix { inherit pkgs; }
