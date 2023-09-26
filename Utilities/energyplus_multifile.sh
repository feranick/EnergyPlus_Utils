#!/bin/sh
#
# energyplus_multifile.sh 
# version 20230926a
#
# Usage: energy_multifile.sh <loc.code>
#

for f in ./*.idf
do echo "Processing $f file..."
 energyplus_launcher.sh $1 $f
done


