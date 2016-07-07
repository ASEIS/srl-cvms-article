#! /bin/sh

#for dir in `ls -d 1*`; do



cd 9064568

awk '{printf "%7.2f\n", $3}' score_report.txt >../f1

cd ..


cd 9753489

awk '{printf "%7.2f\n", $3}' score_report.txt >../f2

cd ..

cd 10530013

awk '{printf "%7.2f\n", $3}' score_report.txt >../f3

cd ..
cd 14155260

awk '{printf "%7.2f\n", $3}' score_report.txt >../f4

cd ..
cd 10216101

awk '{printf "%7.2f\n", $3}' score_report.txt >../f5

cd ..
cd 9716853

awk '{printf "%7.2f\n", $3}' score_report.txt >../f6

cd ..
cd 14116972

awk '{printf "%7.2f\n", $3}' score_report.txt >../f7

cd ..
cd 10370141

awk '{printf "%7.2f\n", $3}' score_report.txt >../f8

cd ..
cd 9140050

awk '{printf "%7.2f\n", $3}' score_report.txt >../f9

cd ..
cd 10541957

awk '{printf "%7.2f\n", $3}' score_report.txt >../f10

cd ..

cd 14494128

awk '{printf "%7.2f\n", $3}' score_report.txt >../f11

cd ..

cd 14239184

awk '{printf "%7.2f\n", $3}' score_report.txt >../f12

cd ..

cd 14000376

awk '{printf "%7.2f\n", $3}' score_report.txt >../f13

cd ..

cd 10972299

awk '{printf "%7.2f\n", $3}' score_report.txt >../f14

cd ..

cd 9096972

awk '{printf "%7.2f\n", $3}' score_report.txt >../f15

cd ..

cd 14312160

awk '{printf "%7.2f\n", $3}' score_report.txt >../f16

cd ..

cd 15237281

awk '{printf "%7.2f\n", $3}' score_report.txt >../f17

cd ..

cd 9703873

awk '{printf "%7.2f\n", $3}' score_report.txt >../f18

cd ..

cd 10410337

awk '{printf "%7.2f\n", $3}' score_report.txt >../f19

cd ..

cd 13692644

awk '{printf "%7.2f\n", $3}' score_report.txt >../f20

cd ..

cd 9093975

awk '{printf "%7.2f\n", $3}' score_report.txt >../f21

cd ..

cd 14601172

awk '{printf "%7.2f\n", $3}' score_report.txt >../f22

cd ..

cd 15481673

awk '{printf "%7.2f\n", $3}' score_report.txt >../f23

cd ..

cd 14383980

awk '{printf "%7.2f\n", $3}' score_report.txt >../f24

cd ..

cd 9818433

awk '{printf "%7.2f\n", $3}' score_report.txt >../f25

cd ..

cd 10399889

awk '{printf "%7.2f\n", $3}' score_report.txt >../f26

cd ..

cd 9644101

awk '{printf "%7.2f\n", $3}' score_report.txt >../f27

cd ..

cd 10275733

awk '{printf "%7.2f\n", $3}' score_report.txt >../f28

cd ..

cd 10403777

awk '{printf "%7.2f\n", $3}' score_report.txt >../f29

cd ..

cd 14738436

awk '{printf "%7.2f\n", $3}' score_report.txt >../f30

cd ..

paste f1  f2  f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 f30 >  col6_event30_cvms426_222_report.dat

rm -f f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 f30

#done 
#cd ..

