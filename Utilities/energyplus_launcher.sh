#!/bin/sh

version=22-2-0
energyplus=/Applications/EnergyPlus-$version/energyplus

wCO=/Applications/EnergyPlus-$version/WeatherData/USA_CO_Golden-NREL.724666_TMY3.epw
wFL=/Applications/EnergyPlus-$version/WeatherData/USA_FL_Tampa.Intl.AP.722110_TMY3.epw
wIL=/Applications/EnergyPlus-$version/WeatherData/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw

echo $1
if [[ "$1" == "CO" ]]; then
  weather=$wCO
elif [[ "$1" == "FL" ]]; then
  weather=$wFL
elif [[ "$1" == "IL" ]]; then
  weather=$wIL
fi

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

