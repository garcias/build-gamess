#!/bin/bash

# Clean up gamess and scratch directories of previous tests
cd ~/gamess
rm exam??.log runall.log
rm /tmp/exam??.* ~/tmp/exam??.*

# Run tests and report output
./runall 00 >& runall.log
grep -i --color 'terminated normally' exam*.log
NUM_PASSED=$(grep -i --color 'terminated normally' exam*.log | wc -l)
echo "GAMESS passed $NUM_PASSED of 47 tests"

# Clean up gamess directory of test files
rm exam??.log runall.log
rm /tmp/exam??.* ~/tmp/exam??.*
