CC=ghdl
SIM=gtkwave

all : test
amd2901.o: amd2901.vhdl
	${CC} -a -v $<

amd_iss.o : amd_iss.vhdl
	ghdl -a -v amd_iss.vhdl

std_log2c.o : std_log2c.c
	gcc -g -Wall -c  std_log2c.c

amd_iss_c.o : amd_iss_c_complet.s
	gcc -g -Wall -c  amd_iss_c_complet.s -o amd_iss_c.o

%.o: %.vhdl
	${CC} -a -v $<

amd_tb.o: amd_tb.vhdl amd_iss_c.o std_log2c.o amd_iss.o amd2901.o
	${CC} -a -Pcells/ -v $<

test: amd_tb.o
	${CC} -e -Wl,amd_iss_c.o -Wl,std_log2c.o -v amd_tb

run : test
	${CC} -r amd_tb --vcd=amd2901.vcd


exe: 
	gtkwave amd2901.vcd

clean:
	rm -fv *.o *.cf *.vcd amd_tb

cleanall: clean
	rm -fv *~ *.vcd *.cf


