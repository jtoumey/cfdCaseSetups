#!/bin/bash

echo ""
echo "WARNING. This script could inadvertently delete files which you wished to save."
echo ""
echo "         The code was developed under the following assumptions:"
echo "          * OpenFOAM time directories were written every thousandth of a second"
echo "          * You only wish to save hundredth of a second time directories"
echo "          * The deletion spans only one second (e.g., 0.xxx or 1.xxx)"
echo "          * The simulation time directories are less than 10 seconds"
echo ""
echo "PRESS CTRL-C IMMEDIATELY TO EXIT IF YOU ARE UNSURE OF THE SCRIPTS BEHAVIOR."
echo ""

read -p "Enter maximum time directory: " MAXDIR

DIRLENGTH=${#MAXDIR}
echo "$DIRLENGTH"

ONES=${MAXDIR:0:1}
TENTHS=${MAXDIR:2:1}
HUNDREDTHS=${MAXDIR:3:1}

echo $DIRLENGTH
if [ $DIRLENGTH == "4" ]; then
    echo "Only hundreds present"
    THOUSANDTHS=0
else
    THOUSANDTHS=${MAXDIR:4:1}
fi

echo "Tenths: $TENTHS"
echo "Hundredths: $HUNDREDTHS"
echo "Thousandths: $THOUSANDTHS"

TENTHS_M1=$((TENTHS-1))
if [ $HUNDREDTHS == "0" ]; then
    HUNDREDTHS_M1=0
else
    HUNDREDTHS_M1=$((HUNDREDTHS-1))
fi
# This condition prevents deletion of the final thousands directory, because we do want to save x.xx1 if it is the newest-written directory
if [ $THOUSANDTHS == "1" ]; then
    THOUSANDTHS=0
else
    THOUSANDTHS_M1=$((THOUSANDTHS-1))
fi

echo ""
echo "DELETING: processor*/$ONES.001 to processor*/$ONES.${TENTHS_M1}99"
read -p "Press [Enter] key to start deletion..."
echo "Deleting..."

rm -rf processor*/$ONES.[0-$TENTHS_M1][0-9][0-9]

#
if [ $HUNDREDTHS == "0" ]; then
    TH_DELETE=$THOUSANDTHS_M1
else
    TH_DELETE=9
fi
echo $TH_DELETE

echo ""
echo "DELETING: processor*/$ONES.${TENTHS}01 to processor*/$ONES.${TENTHS}${HUNDREDTHS_M1}${TH_DELETE}"
read -p "Press [Enter] key to start deletion..."
echo "Deleting..."
rm -rf processor*/$ONES.$TENTHS[0-$HUNDREDTHS_M1][0-$TH_DELETE]

if [ $THOUSANDTHS != "0" ] && [ $HUNDREDTHS != "0" ]; then
    echo ""
    echo "DELETING: processor*/$ONES.${TENTHS}${HUNDREDTHS}1 to processor*/$ONES.${TENTHS}${HUNDREDTHS}${THOUSANDTHS_M1}"
    read -p "Press [Enter] key to start deletion..."
    echo "Deleting..."
    rm -rf processor*/$ONES.$TENTHS$HUNDREDTHS[0-$THOUSANDTHS_M1]
fi
