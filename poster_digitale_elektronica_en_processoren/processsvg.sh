#!/bin/bash

basnam=$(basename "$1" ".svg")
inkscape --shell --verb=FitCanvasToDrawing --verb=FileSave --verb=FileClose "$1"
rsvg-convert -f pdf -o "$basnam.pdf" "$1"
