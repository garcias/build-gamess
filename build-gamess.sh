#!/bin/bash

ATLAS_DIR=/usr/lib/atlas-base

tar -xzf gamess-current.tar.gz
mv gamess/ ~
rm gamess-current.tar.gz

echo "gfortran is version $(gfortran -dumpversion)"
echo "atlas libraries are in: $ATLAS_DIR"

cd ~
mkdir ~/tmp

cd ~/gamess
./config

# build DDI
cd ddi
./compddi >& compddi.log
mv ddikick.x ..
cd ..

# build everything
./compall >& compall.log

# the following searches should generate no output
grep -i --color "error" compall.log
grep -i --color "cannot stat" compall.log

# link objects; search should return success message
./lked gamess 00 >& lked.log
grep -i --color "successful" lked.log

echo "PATH=$PATH:~/gamess" >> ~/.bashrc

# Manual configuration
echo "=================================================="
echo "  Building of GAMESS done"
echo "  Added ~/gamess to PATH in .bashrc"
echo "  source ~/.bashrc before using gamess"
echo "=================================================="
echo "  Edit rungms to set paths"
echo "  Open rungms and find the following 3 lines:"
echo "    set SCR=/scr/$USER"
echo "    set USERSCR=/u1/$USER/scr"
echo "    set GMSPATH=/u1/mike/gamess"
echo "  Change them to:"
echo "    set SCR=/tmp"
echo "    set USERSCR=~/tmp"
echo "    set GMSPATH=~/gamess"
echo "=================================================="