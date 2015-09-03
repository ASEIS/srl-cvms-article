    
clear

gmt gmtset FONT_LABEL              = 12
gmt gmtset MAP_FRAME_PEN           = 0.75p,black
gmt gmtset MAP_FRAME_WIDTH         = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p,black

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p

EVENT=$1
CVM=$2

ROOTNAME=${EVENT}-${CVM}
INPUTFILE=../data-plain/pgv/${ROOTNAME}.txt
OUTPUTFILE=${ROOTNAME}.ps
SHORE=xy-shoreline.txt
THEGRID=cvm.grd
THECPT=tmp.cpt
CONT=0.25,black

gmt gmtinfo $INPUTFILE

DMIN=0.5
DMAX=50
# LSTP=0.2

gmt makecpt -Ccon-yl-or-rd.cpt -T$DMIN/$DMAX/2 -Qo > $THECPT

# COMPLETE PDF PLOT

gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R0/180000/0/135000 -V -Dmeter/meter/degree/1/0/=/=
gmt psbasemap -JX6i/4.5i -Y6.7i -Bwesn -R -P -V -K > ${OUTPUTFILE}
gmt grdimage $THEGRID -JX -R -B -C$THECPT -K -O >> ${OUTPUTFILE}
gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R -Dmeter/meter/degree/1/0/=/=
gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${OUTPUTFILE}
gmt psxy $SHORE -R -J -W0.75p -G30/120/190@50 -K -O >> ${OUTPUTFILE}

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p
gmt psbasemap -J -Bf200000wesn -R -K -O >> ${OUTPUTFILE}
gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p
gmt gmtset MAP_GRID_PEN_PRIMARY = 0.75,black
gmt psscale -C$THECPT -L -D0.0/0.0/4i/0.25i -E -X6.25i -Y2i -Q -V -O >> ${OUTPUTFILE}

gmt ps2raster ${OUTPUTFILE} -Tf -Au1cm -F${ROOTNAME}-all

open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}-all.pdf

rm ${ROOTNAME}.ps

#  CONTOURS ONLY

gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R0/180000/0/135000 -V -Dmeter/meter/degree/1/0/=/=
gmt psbasemap -JX6i/4.5i -Y6.72i -Bwesn -R -P -V -K > ${OUTPUTFILE}
gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R -Dmeter/meter/degree/1/0/=/=
gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${OUTPUTFILE}
gmt psxy $SHORE -R -J -W0.75p -G30/120/190@50 -K -O >> ${OUTPUTFILE}

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p
gmt psbasemap -J -Bf200000wesn -R -K -O >> ${OUTPUTFILE}
gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p
gmt gmtset MAP_GRID_PEN_PRIMARY = 0.75,black
gmt psscale -C$THECPT -L -D0.0/0.0/4i/0.25i -E -X6.25i -Y2i -Q -V -O >> ${OUTPUTFILE}

gmt ps2raster ${OUTPUTFILE} -Tf -Au1cm -F${ROOTNAME}-con

open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}-con.pdf

rm ${ROOTNAME}.ps

# PNG

gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R0/180000/0/135000 -V -Dmeter/meter/degree/1/0/=/=
gmt psbasemap -JX6i/4.5i -Y6.72i -Bwesn -R -P -V -K > ${OUTPUTFILE}
gmt grdimage $THEGRID -JX -R -B -C$THECPT -O >> ${OUTPUTFILE}
# gmt xyz2grd $INPUTFILE -G$THEGRID -I500/500 -R -Dmeter/meter/degree/1/0/=/=
# gmt grdcontour $THEGRID -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${OUTPUTFILE}
# gmt psxy $SHORE -R -J -W0.75p -G30/120/190@50 -K -O >> ${OUTPUTFILE}

# gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p
# gmt psbasemap -J -Bf200000wesn -R -K -O >> ${OUTPUTFILE}
# gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p
# gmt gmtset MAP_GRID_PEN_PRIMARY = 1,black
# gmt psscale -C$THECPT -L -D0.0/0.0/4i/0.25i -E -X6.25i -Y2i -Q -V -O >> ${OUTPUTFILE}

gmt ps2raster ${OUTPUTFILE} -TG -Au -F${ROOTNAME}-png


rm *.grd gmt.conf gmt.history *.ps