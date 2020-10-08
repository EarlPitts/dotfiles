#!/bin/bash

MKD2HTML=mkd2html

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FORCEFLAG=

[ $FORCE -eq 0 ] || { FORCEFLAG="-f"; };
[ $SYNTAX = "markdown" ] || { echo "Error: Unsupported syntax"; exit -2; };

OUTPUT="$OUTPUTDIR"/$(basename "$INPUT" .$EXTENSION).html

$MKD2HTML -css "style.css" "$INPUT"
OUTPUTTMP=$(dirname "$INPUT")/$(basename "$INPUT" ."$EXTENSION").html
mv -f "$OUTPUTTMP" "$OUTPUT"



