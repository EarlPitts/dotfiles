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
MATHJAX1='<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>'
MATHJAX2='<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>'
INLINE='<script>window.MathJax={tex:{inlineMath:[["$","$"],["\\(","\\)"]]}};</script>'

<<<<<<< HEAD

$MKD2HTML -css "style.css" -header "$MATHJAX1" -header "$MATHJAX2" -header "$INLINE" "$INPUT"
=======
MATHJAX1='<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>'
MATHJAX2='<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>'
INLINE='<script>window.MathJax={tex:{inlineMath:[["$","$"],["\\(","\\)"]]}};</script>'




$MKD2HTML -css "style.css" -h  "$INPUT"
>>>>>>> 02ca3a7ab4641ee07aa64a4edad04b537952a354
OUTPUTTMP=$(dirname "$INPUT")/$(basename "$INPUT" ."$EXTENSION").html
mv -f "$OUTPUTTMP" "$OUTPUT"



