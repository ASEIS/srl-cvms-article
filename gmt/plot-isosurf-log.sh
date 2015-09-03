
clear

gmt gmtset FONT_LABEL              = 12

gmt gmtset MAP_FRAME_PEN           = 0.75p,black
gmt gmtset MAP_FRAME_WIDTH         = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p,black,_

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p

CVM=$1
TARGET=$2
#CMIN=$3
#CMAX=$4
#STEP=$5
CMIN=5
CMAX=2000
STEP=2

INPUTFILE=../data-plain/iso/iso-target${TARGET}-s250-dz25-${CVM}.txt
#EPICENTER=xy-epicenter.txt
    SHORE=xy-shoreline.txt

 THEGRID=iso.grd
ROOTNAME=iso-target${TARGET}-s250-dz25-${CVM}
 OUTFILE=${ROOTNAME}.ps
  THECPT=tmp.cpt
  
CONT=0.5p,120,3_1:0p

gmt minmax $INPUTFILE

gmt xyz2grd $INPUTFILE -G$THEGRID -I250/250 -R0/180000/0/135000 -Dmeter/meter/degree/1/0/=/=

gmt makecpt -Cdepth.cpt -T$CMIN/$CMAX/$STEP -Qo -Z > $THECPT

gmt psbasemap -JX6i/4i -Y7.2i -Bwesn -R0/180000/0/135000 -P -K > $OUTFILE

gmt grdimage $THEGRID -JX -R -C$THECPT -K -O >> $OUTFILE

gmt xyz2grd $INPUTFILE -G$THEGRID -I750/750 -R0/180000/0/135000 -Dmeter/meter/degree/1/0/=/=

gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> $OUTFILE

#psxy $SHORE -R -J -W0.75p -V -K -O >> $OUTFILE
gmt psxy $SHORE -R -J -W0.75p -G30/120/190@40 -K -O >> $OUTFILE
#psxy $EPICENTER -R -J -Sa10p -Gyellow -Wthin -K -O >> $OUTFILE

#psxy ../data-plain/vslide-lines.txt -R -J -W1p,red -V -K -O >> $OUTFILE

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p

gmt psbasemap -J -Bf200000wesn -R -K -O >> $OUTFILE

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p/3p

gmt gmtset MAP_GRID_PEN_PRIMARY    = $CONT

#psscale -C$THECPT -D0.0/0.0/4i/0.25i -E -X6.25i -Y2i -Q -V -K -O >> $OUTFILE
gmt psscale -C$THECPT -Ba1 -D0.0/0.0/4i/0.25i -E -X6.25i -Y2i -Q -V -K -O >> $OUTFILE

gmt psbasemap -JX0.25i/4il -B/f3g${STEP}E -R0/1/$CMIN/$CMAX -Y-2i -K -O >> $OUTFILE

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p

gmt psbasemap -J -Bf10000wesn -R -O >> $OUTFILE

gmt ps2raster $OUTFILE -Tf

open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}.pdf

rm $THEGRID
rm $OUTFILE
rm $THECPT

