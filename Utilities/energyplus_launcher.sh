#!/bin/sh

version=22-2-0
energyplus=/Applications/EnergyPlus-$version/energyplus

weather=/Applications/EnergyPlus-$version/WeatherData/USA_CO_Golden-NREL.724666_TMY3.epw

echo $energyplus
echo $weather

iddfile=${1%????}
mkdir $iddfile
cd $iddfile

$energyplus -w $weather -r ../$1
