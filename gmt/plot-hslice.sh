    
clear

gmt gmtset FONT_LABEL              = 12
gmt gmtset MAP_FRAME_PEN           = 0.75p,black
gmt gmtset MAP_FRAME_WIDTH         = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p,black,_

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p

CVM=$1
DEPTH=$2

ROOTNAME=hcut-depth${DEPTH}-s250-${CVM}
INPUTFILE=../data-plain/hcut/${ROOTNAME}.txt
SHORE=xy-shoreline.txt

THEGRID=cvm.grd

THECPT=srt-yl-or-br-9.cpt

CONT=0.5p,120
# CONT=0.5p,black,2_2:0p

gmt minmax $INPUTFILE

gmt xyz2grd $INPUTFILE -G$THEGRID -I250/250 -R0/180000/0/135000 -V -Dmeter/meter/degree/1/0/=/=

gmt psbasemap -JX6i/4.5i -Y6.8i -Bwesn -R -P -V -K > ${ROOTNAME}.ps

gmt grdimage $THEGRID -JX -R -B -C$THECPT -K -O >> ${ROOTNAME}.ps

gmt xyz2grd $INPUTFILE -G$THEGRID -I750/750 -R -Dmeter/meter/degree/1/0/=/=
gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOTNAME}.ps

gmt psxy $SHORE -R -J -W0.75p -G30/120/190@40 -K -O >> ${ROOTNAME}.ps
#gmt psxy $EPICENTER -R -J -Sa10p -Gyellow -Wthin -K -O >> ${ROOTNAME}.ps

# psxy ../data-plain/vslide-lines.txt -R -J -W1p,red -V -K -O >> ${ROOTNAME}.ps
# psxy ../data-plain/hr-cvmh-box.txt -R -J -W1p,blue -V -K -O >> ${ROOTNAME}.ps

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p

gmt psbasemap -J -Bf200000wesn -R -K -O >> ${ROOTNAME}.ps

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p

gmt gmtset MAP_GRID_PEN_PRIMARY = $CONT
gmt psscale -C$THECPT -D0.0/0.0/4i/0.25i -E -L -X6.25i -Y2i -O >> ${ROOTNAME}.ps

gmt ps2raster ${ROOTNAME}.ps -Tef

open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}.pdf

rm cvm.grd
rm ${ROOTNAME}.ps
rm ${ROOTNAME}.eps
