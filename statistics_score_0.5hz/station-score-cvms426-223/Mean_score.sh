#!/bin/sh

#set -xv

for i in $(ls)


do
echo $i
cd $i
rm score_report.txt


while read j; do

st_name=station.$j

sc=`cat scores.txt | grep $st_name | awk '{print $6 " " $8 " " $9 " " $10 " " $11}'`

echo $i $st_name $sc >> score_report.txt

done <numbers.txt

cd ..

done