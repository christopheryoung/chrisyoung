#!/bin/bash

# Updates cabal and cabal-install, installs hsenv if it isn't already
# installed, activates the hsenv, and then installs hakyll into it

cabal update
cabal install cabal-install

type hsenv >/dev/null 2>&1 || cabal install hsenv
hsenv

source ./hsenv/bin/activate
cabal install hakyll
