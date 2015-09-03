
clear

gmt gmtset FONT_LABEL              = 12
gmt gmtset MAP_FRAME_PEN           = 0.75p,black
gmt gmtset MAP_FRAME_WIDTH         = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p
gmt gmtset MAP_GRID_PEN_PRIMARY    = 0.75p,black,_

gmt gmtset MAP_FRAME_PEN           = 0.75p
gmt gmtset MAP_TICK_PEN_PRIMARY    = 0.75p

CVM=$1

A1=AB
A2=BC

SX=50
SZ=5

# Distances
L1=90000
L2=114300

SL1=90
SL2=114.3
SLT=204.3

# Depths
Z0=0
Z1=400
Z2=2000
Z3=8000

SZ0=0
SZ1=0.4
SZ2=2
SZ3=8

# Axes ticks and labels marks
LBL1=2; TCK1=1
LBL2=0.4; TCK2=0.2
LBL3=0.1; TCK3=0.05

ROOT=vcut-ABC-${CVM}

NAME1=vcut-AB-${CVM}-dx${SX}-dz${SZ}-d${Z3}
NAME2=vcut-BC-${CVM}-dx${SX}-dz${SZ}-d${Z3}

INPUTFILE1=../data-plain/vcuts/${NAME1}.txt
INPUTFILE2=../data-plain/vcuts/${NAME2}.txt

GRID1=${NAME1}.grd
GRID2=${NAME2}.grd

THECPT=yl-or-br-9.cpt

# Regular contours
CONT=0.25p,125

# Special contours
echo "1000 C" >  tmp.txt
echo "2500 C" >> tmp.txt

# Contructing Grids
# -----------------

# gmt minmax  $INPUTFILE1
gmt xyz2grd $INPUTFILE1 -G$GRID1 -I${SX}/${SZ} -R0/${L1}/${Z0}/${Z3} -V -Dmeter/meter/degree/1/0/=/=

# gmt minmax  $INPUTFILE2
gmt xyz2grd $INPUTFILE2 -G$GRID2 -I${SX}/${SZ} -R0/${L2}/${Z0}/${Z3} -V -Dmeter/meter/degree/1/0/=/=

# Bottom AB Section
# -----------------

gmt psbasemap -JX2.800i/-0.75i -X0.7i -Y8.5i -Bws -R0/${L1}/${Z2}/${Z3} -P -V -K > ${ROOT}.ps
gmt grdimage   $GRID1 -JX -R -B -C$THECPT -E720 -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -JX6.356i/-0.75i -Ba20f10:"Distance (km)":/a${LBL1}f${TCK1}SW -R0/${SLT}/${SZ2}/${SZ3} -K -O >> ${ROOT}.ps

# Middle AB Section
# -----------------

gmt psbasemap -JX2.800i/-1i -Y0.75i -Bws -R0/${L1}/${Z1}/${Z2} -P -V -K -O >> ${ROOT}.ps
gmt grdimage   $GRID1 -JX -R -B -C$THECPT -E720 -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -J -B${LBL2}f${TCK2}:"Depth (km)":W -R0/${SL1}/${SZ1}/${SZ2} -K -O >> ${ROOT}.ps

# Top AB Section
# -----------------

gmt psbasemap -JX2.800i/-1i -Y1i -Bws -R0/${L1}/${Z0}/${Z1} -P -V -K -O >> ${ROOT}.ps
gmt grdimage   $GRID1 -JX -R -B -C$THECPT -E720 -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID1 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -J -Ba${SL1}f10/a${LBL3}f${TCK3}nW -R0/${SL1}/${SZ0}/${SZ1} -K -O >> ${ROOT}.ps

# Top BC Section
# -----------------

gmt psbasemap -JX3.556i/-1i -X2.8i -Bws -R0/${L2}/${Z0}/${Z1} -P -V -K -O >> ${ROOT}.ps
gmt grdimage   $GRID2 -JX -R -B -C$THECPT -E720 -K -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -J -Ba${SL2}f10/a${LBL3}f${TCK3}en -R0/${SL2}/${SZ0}/${SZ1} -K -O >> ${ROOT}.ps
gmt psbasemap -J -Bw -R0/${SL2}/${SZ0}/${SZ1} -K -O >> ${ROOT}.ps

# Middle BC Section
# -----------------

gmt psbasemap -JX3.556i/-1i -Y-1i -Bws -R0/${L2}/${Z1}/${Z2} -P -V -K -O >> ${ROOT}.ps
gmt grdimage   $GRID2 -JX -R -B -C$THECPT -E720 -K -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -J -Ba${LBL2}f${TCK2}e -R0/${SL2}/${SZ1}/${SZ2} -K -O >> ${ROOT}.ps

# Bottom BC Section
# -----------------

gmt psbasemap -JX3.556i/-0.75i -Y-0.75i -Bws -R0/${L2}/${Z2}/${Z3} -P -V -K -O >> ${ROOT}.ps
gmt grdimage   $GRID2 -JX -R -B -C$THECPT -E720 -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -C$THECPT -A- -W$CONT -V -K -O >> ${ROOT}.ps
gmt grdcontour $GRID2 -JX -R -B -Ctmp.txt -A+a0 -W0.5p,black -V -K -O >> ${ROOT}.ps
gmt psbasemap -J -Ba${SL2}/a${LBL1}f${TCK1}es -R0/${SL2}/${SZ2}/${SZ3} -K -O >> ${ROOT}.ps

# Colorscale
# ----------

gmt gmtset MAP_TICK_LENGTH_PRIMARY = 6p
gmt gmtset MAP_GRID_PEN_PRIMARY    = $CONT

gmt psscale -C$THECPT -D0.0/0.0/2.75i/0.25i -E -L -X3.806i -Y1.375i -O >> ${ROOT}.ps

gmt ps2raster ${ROOT}.ps -Tf
gmt ps2raster ${ROOT}.ps -TG -A

open -a Adobe\ Acrobat\ Pro.app ${ROOT}.pdf

rm ${GRID1} ${GRID2}
rm ${ROOT}.ps
