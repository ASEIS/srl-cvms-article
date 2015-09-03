
clear

gmt gmtset FONT_LABEL              = 12
gmt gmtset MAP_FRAME_PEN           = 0.75p,black
gmt gmtset MAP_FRAME_WIDTH         = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p,black,_

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p

CVM=$1
AA=$2

SX=$3
SZ=$4
ZZ=$5

if [ $AA = "AB" ]
then
    LL=90000
else
    LL=180000
fi

# LBL=$(echo $ZZ/5 | bc -l)
# TCK=$(echo $ZZ/20 | bc -l)

LBL=200
TCK=100

ROOTNAME=vcut-${AA}-${CVM}-dx${SX}-dz${SZ}-d${ZZ}

INPUTFILE=../data-plain/vcuts/${ROOTNAME}.txt

THEGRID=${ROOTNAME}.grd

THECPT=yl-or-br-9.cpt

CONT=0.25p,125

gmt minmax $INPUTFILE

gmt xyz2grd $INPUTFILE -G$THEGRID -I${SX}/${SZ} -R0/${LL}/0/${ZZ} -V -Dmeter/meter/degree/1/0/=/=

gmt psbasemap -JX6i/-4i -Y7.2i -Bwesn -R -P -V -K > ${ROOTNAME}.ps

gmt grdimage $THEGRID -JX -R -B -C$THECPT -K -O >> ${ROOTNAME}.ps

gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A+a0 -W$CONT -V -K -O >> ${ROOTNAME}.ps

gmt psbasemap -J -Ba${LBL}f${TCK}:"Depth (m)":W -R -K -O >> ${ROOTNAME}.ps

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p

gmt psbasemap -J -Bf200000wesn -R -K -O >> ${ROOTNAME}.ps

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p

gmt gmtset MAP_GRID_PEN_PRIMARY = $CONT

gmt psscale -C$THECPT -D0.0/0.0/4i/0.25i -E -L -X6.25i -Y2i -O >> ${ROOTNAME}.ps

gmt ps2raster ${ROOTNAME}.ps -Tf

open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}.pdf

rm ${THEGRID}
rm ${ROOTNAME}.ps
