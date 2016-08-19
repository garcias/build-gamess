#!/bin/bash

REPO_DIR=$(pwd)
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

cp rungms rungms-old
sed --in-place=.bak s/"\/scr\/\$USER"/"\/tmp"/g rungms 
sed --in-place=.bak s/"\/u1\/\$USER\/scr"/"\~\/tmp"/g rungms 
sed --in-place=.bak s/"\/u1\/mike"/"\~"/g rungms 
rm rungms.bak

# archive and save in repository
tar -czf $REPO_DIR/gamess-built.tar.gz ~/gamess

# Run tests and report output
./runall 00 >& runall.log
grep -i --color 'terminated normally' exam*.log > exam-report.log
NUM_PASSED=$(cat exam-report.log | wc -l)
echo "GAMESS passed $NUM_PASSED of 47 tests"
echo "Check exam-report.log for list of failed tests"

# Manual configuration
echo "=================================================="
echo "  Building of GAMESS done"
echo "  Added ~/gamess to PATH in .bashrc"
echo "  source ~/.bashrc before using gamess"
echo "  Archived as gamess-built.tar.gz"
echo "=================================================="
