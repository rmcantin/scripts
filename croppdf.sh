#!/bin/bash
#
# File to download, crop and open a pdf ready for printing in multipage.
# Intended to use for those book formated papers.
#
# Usage: ./croppdf.sh <URL of pdf>
# Example: ./croppdf.sh http://users.isr.ist.utl.pt/~rmcantin/papers/tesis.pdf
#
# Author: Ruben Martinez-Cantin <rmcantin@unizar.es>
#

# Remove version number
os=${OSTYPE//[0-9.]/}

if [ $# -ne 1 ]; then
    echo "USAGE: You need to specify a URL or local path"
    exit
fi

path = "$1"

regex='(https?|ftp)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ $path =~ $regex ]] 
then 
    wget $path -O temp_before_crop.pdf
else
    mv $path ./temp_before_crop.pdf
fi

pdfcrop temp_before_crop.pdf output.pdf
rm temp_before_crop.pdf

if [ "$os" = "darwin" ]; then
    open output.pdf
elif [ "$os" = "linux-gnu" ]; then
    xdg-open output.pdf
fi
