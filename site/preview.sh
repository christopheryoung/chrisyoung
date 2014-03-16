#!/bin/bash
ghc --make -fwarn-unused-imports -fwarn-unused-binds -fwarn-overlapping-patterns -fwarn-missing-signatures -fwarn-hi-shadowing -fwarn-missing-fields -fwarn-missing-methods site.hs

if [ $? -eq 0 ]
then
    ./site rebuild
    ./site watch
fi
