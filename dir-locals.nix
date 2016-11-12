let pkgs = import <nixpkgs> {}; in
  pkgs.nixBufferBuilders.withPackages [ pkgs.coq pkgs.coqPackages.fiat_HEAD ]
