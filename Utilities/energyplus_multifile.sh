#!/bin/sh
#
# energyplus_multifile.sh 
# version 20230922a
#

for f in ./*.idf
do echo "Processing $f file..."
 energyplus_launcher.sh $1 $f
done


