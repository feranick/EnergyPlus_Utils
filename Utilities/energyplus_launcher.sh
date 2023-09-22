#!/bin/sh
#
# energyplus_launcher.sh
# version 20230922a
#

version=23-1-0
energyplus=/Applications/EnergyPlus-$version/energyplus

wCO=/Applications/EnergyPlus-$version/WeatherData/USA_CO_Golden-NREL.724666_TMY3.epw
wFL=/Applications/EnergyPlus-$version/WeatherData/USA_FL_Tampa.Intl.AP.722110_TMY3.epw
wIL=/Applications/EnergyPlus-$version/WeatherData/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw

CSVfile="results"

echo $1
if [[ "$1" == "CO" ]]; then
  weather=$wCO
  CSVfile=$CSVfile"_CO"
elif [[ "$1" == "FL" ]]; then
  weather=$wFL
  CSVfile=$CSVfile"_FL"
elif [[ "$1" == "IL" ]]; then
  weather=$wIL
  CSVfile=$CSVfile"_IL"
fi

CSVfile=$CSVfile".csv"

echo $energyplus
echo $weather

iddfile=${2%????}
mkdir $iddfile
cd $iddfile

$energyplus -w $weather -r ../$2
h=$(sed -n 173p eplustbl.htm)
heating=${h:26:8}

c=$(sed -n 188p eplustbl.htm)
cooling=${c:26:8}

tse1=$(sed -n 38p eplustbl.htm)
TotSiteEn=${tse1:26:8}

tse2=$(sed -n 50p eplustbl.htm)
TotSourceEn=${tse2:26:8}

echo
echo $iddfile
echo $weather
echo "Cooling: $cooling GJ"
echo "Heating: $heating GJ"
echo "Total Site Energy: $TotSiteEn GJ"
echo "Total Source Energy: $TotSourceEn GJ"
echo

echo $iddfile >> results.txt
echo $weather >> results.txt
echo "Cooling: $cooling GJ" >> results.txt
echo "Heating: $heating GJ" >> results.txt
echo "Total Site Energy: $TotSiteEn GJ" >> results.txt
echo "Total Source Energy: $TotSourceEn GJ" >> results.txt

cd ..

if [ ! -f "$CSVfile" ]; then
  echo File,Location,Cooling GJ,Heating GJ,TotSiteEn GJ,TotSourceEn GJ,Weather >> $CSVfile
fi

echo $iddfile,$1,$cooling,$heating,$TotSiteEn,$TotSourceEn,$weather >> $CSVfile
