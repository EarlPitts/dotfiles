#!/usr/bin/bash

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

pandoc --mathjax --quiet -s "$INPUT" -o "$OUTPUTDIR"/$(basename $INPUT | cut -d"." -f1).html


