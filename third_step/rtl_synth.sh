#!/bin/sh

if [ $# -ne 1 ]
	then
	echo "Usage : vlsi_synth fichier_source (avec extension .vhdl)"
	exit 1
fi

nomf=`basename $1 ".vhdl"`


vasy -I vhdl -V -o -a $nomf.vhdl $nomf

boom $nomf ${nomf}_o
boog ${nomf}_o $nomf

vasy -I vst -s -o -S $nomf ${nomf}

sed "/ENTITY/i\library cells;\nuse cells.all;\n" ${nomf}.vhd > ${nomf}_net.vhdl

echo synthese terminee !!
