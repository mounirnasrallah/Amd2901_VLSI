all: par

### place and route rules ###
par : cleanap place route

place :
	python par.py

route :
	nero -V -p amd2901 amd2901 amd2901

validate : druc cougar lvx

druc :
	export RDS_TECHNO_NAME=/soc/alliance/etc/cmos.rds && druc amd2901

cougar :
	export MBK_OUT_LO=al && cougar -f amd2901 && export MBK_OUT_LO=vst

lvx :
	lvx vst al amd2901 amd2901 -f
cleanap :
	rm -f *.ap
### end place and route rules ###


### timing analysis rules ###
ap2spi :
	export RDS_TECHNO_NAME=/users/soft/techno/labo/035/extract/prol035.rds && export MBK_IN_PH=ap && export MBK_OUT_LO=spi && cougar -v -t -ac amd2901
### end timing analysis rules ###

clean :
	rm -f *xsc *vbe *vhd *~ *drc *cif *.o *# e~* *_net* *stat *stm *cns *cnv *rep *loop
