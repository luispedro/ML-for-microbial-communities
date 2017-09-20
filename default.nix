#!/usr/bin/env nix-shell
with import <nixpkgs> {};

let
    envname = "ml-microbes-talk";
    python = python27Full;
    pyp = pkgs.python27Packages;
    rise = pyp.buildPythonPackage rec {
      name = "RISE-${version}";
      version = "4.0.0b1";

      src = pkgs.fetchFromGitHub {
        owner = "damianavila";
        repo = "RISE";
        rev = "7e56b84cf25500c598c45ebf06f55fb2c3357a67";
        sha256 = "02jgdnwwccb4gl397c19jngslpq8nr7bjs2bl0hypmdifndzyinh";
      };
      propagatedBuildInputs = [ pyp.jupyter ];
      doCheck = false;
    };

in

pyp.buildPythonPackage {
  name = "${envname}-env";
  buildInputs = [
     python
     cacert
    ];
   pythonPath = with pyp; [
    jupyter_client
    jupyter_console
    scikitlearn
    ipywidgets
    ipykernel
    notebook
    ipython
    rise

    seaborn
    matplotlib

    numpy
    scipy
    pyside
    readline
    numpydoc
    virtualenv
  ];
  src = null;
  # When used as `nix-shell --pure`
  shellHook = ''
  export NIX_ENV="[${envname}] "
  '';
  # used when building environments
  extraCmds = ''
  export NIX_ENV="[${envname}] "
  '';
}

