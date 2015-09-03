
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
  CMAX=$3
  STEP=$4

   AZI=160
   ELE=60
  CMIN=0

TICK=$(echo "2*$STEP" | bc -l)

INPUTFILE=../data-plain/iso/iso-target${TARGET}-s250-dz25-${CVM}.txt
#EPICENTER=xy-epicenter.txt
    SHORE=xy-shoreline.txt

 THEGRID=iso.grd
ROOTNAME=${CVM}-3diso-${TARGET}ms
 OUTFILE=${ROOTNAME}.ps
  
CONT=1p,red

PERSP=$AZI/$ELE
SEACOLOR=30/120/190@60

# run limits on dataset
gmt minmax $INPUTFILE

# build grid file
gmt xyz2grd $INPUTFILE -G$THEGRID -I2000/2000 -R0/180000/0/135000 -Dmeter/meter/degree/1/0/=/=
gmt grdcut $THEGRID -G$THEGRID -Z/$CMAX -V

# building the colormap
THECPT=tmp.cpt
# makecpt -Cdepth.cpt -T0/$CMAX/$STEP -A+100 -Z > $THECPT
gmt makecpt -Cdepth.cpt -T0/$CMAX/$STEP -Z > $THECPT
sed "1s/0/5/" tmp.cpt > tmp1
echo "0 225/255/225 5 225/255/225" > tmp2
cat tmp2 tmp1 > tmp.cpt
rm tmp1 tmp2

# THECPT=depth${CMAX}.cpt

# setup initial reference frame, no lines
gmt psbasemap -JX5i/3.7i -Y4.5i -Bwesn -R0/180000/0/135000 -p$PERSP/0 -P -K > $OUTFILE

# plot the surface with transparent facades and contour lines
gmt grdview $THEGRID -C$THECPT -R0/180000/0/135000/0/$CMAX -S0.25 -J -JZ-2i -p$PERSP/0 -Wm0.25p,200 -N${CMAX}/200 -Bz2000 -Qs -Wc -Wm -V -K -O >> $OUTFILE

# grdview $THEGRID -C$THECPT -R0/180000/0/135000/0/$CMAX -S0.25 -J -JZ-4i -p$PERSP/0 -N${CMAX}/200 -Bz2000 -Qi50 -V -K -O >> $OUTFILE

# grdview $THEGRID -C$THECPT -R0/180000/0/135000/0/$CMAX -S0.25 -J -JZ-4i -p$PERSP/0 -Qs+m150 -Wc -V -K -O >> $OUTFILE


# shore
gmt psxy $SHORE -R -JX -JZ -W0.75p -G$SEACOLOR -p -K -O >> $OUTFILE

# hr cvms box
# psxy ../data-plain/hr-cvmh-box.txt -R -JX -JZ -W1p,red,4_2:0p -p -K -O >> $OUTFILE

# re-plot top frame without ticks
gmt gmtset MAP_TICK_LENGTH_PRIMARY = 0p
gmt psbasemap -R -J -JZ -Bf200000wesnZ -p -K -O >> $OUTFILE

# plot color bar
gmt gmtset MAP_TICK_LENGTH_PRIMARY = 7p/3p
# psscale -C$THECPT -Ba1 -D0.0/0.0/4i/0.25ih -E -X3i -Y-1i -Q -V -O >> $OUTFILE
gmt psscale -C$THECPT -Ba${TICK}f${STEP}g${STEP} -D0.0/0.0/4i/0.25ih -E -X3i -Y-1i -V -O >> $OUTFILE

# convert to pdf
gmt ps2raster $OUTFILE -Tf

# open pdf file
open -a Adobe\ Acrobat\ Pro.app ${ROOTNAME}.pdf

# remove unnecessary files
rm $THEGRID
rm $OUTFILE
# rm $THECPT
rm gmt.conf