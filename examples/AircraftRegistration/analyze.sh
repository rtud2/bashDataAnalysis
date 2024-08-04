#!/bin/bash

# Data Path
# https://www.faa.gov/licenses_certificates/aircraft_certification/aircraft_registry/releasable_aircraft_download
#
dt='/d/shellscript/bashDataAnalysis/data/AircraftRegistration/'

# echo "Create Column Names"
colnames="$(head -n1 ${dt}MASTER.txt),$(head -n1 ${dt}ACFTREF.txt),$(head -n1 ${dt}ENGINE.txt)"
echo ${colnames} > master_acft_eng.csv


# echo "JOIN MASTER with AIRCRAFT MANUFACTURER"
join -t, -1 3 -2 1\
	<(awk 'NR > 1' "${dt}MASTER.txt" | sort -t, -k3)\
	<(awk 'NR > 1' "${dt}ACFTREF.txt" | sort -t, -k1)\
	> master_acft.csv;


# echo " JOIN master_acft.csv with ENGINES"
join -t, -1 4 -2 1\
	<(sort -t, -k4 master_acft.csv)\
	<(awk 'NR > 1' "${dt}ENGINE.txt" | sort -t, -k1) >> master_acft_eng.csv


# print out the column name and column number
echo "...printing column name and column number..."
echo ""
awk -F, -i ../../awk/stats.awk \
	'
	BEGIN{OFS = ","};
	NR == 1 {stats::head()}' master_acft_eng.csv | column -s, -t


# United Airlines Aircrafts!
echo ${colnames} > united.csv;
grep 'UNITED AIRLINES' master_acft_eng.csv >> united.csv

# grab the column names and the column number
# head -n1 master_acft_eng.csv | awk -F, 'BEGIN{OFS=","};{for(i=1; i<NF; i++){print $i, i}}' | column -s, -t
# count the aircrafts of united
#
echo ""
echo "...Counting United Aircrafts..."
echo ""
echo "Aircraft		Engine	cnt"

awk -F, 'BEGIN{
		OFS=","
	};
	NR > 1 {
		AC[$37,$50]++
	};
	END{
		for(idx in AC){
			print idx, AC[idx];
		}
	}' united.csv | sort -t, -k2nr | column -s, -t
