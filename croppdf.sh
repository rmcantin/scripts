#!/bin/bash

# Remove version number
os=${OSTYPE//[0-9.]/}

if [ $# -ne 1 ]; then
    echo "USAGE: You need to specify a URL path"
    exit
fi

wget $1 -O temp_before_crop.pdf
pdfcrop temp_before_crop.pdf output.pdf
rm temp_before_crop.pdf

if [ "$os"="darwin" ]; then
    open output.pdf
elif [ "$os"="linux-gnu" ]; then
    acroread output.pdf
fi