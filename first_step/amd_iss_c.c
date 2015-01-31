#include "std_log2c.h"
#include "amd_iss_c.h"

void amd_run( Amd_port *port)
//Amd_out amd_run( Amd_in *in)
	{
	static unsigned int ram[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
	static unsigned int accu = 15;

	unsigned int r, s, alu_out;
	//Amd_out out;

	unsigned int a = std2ui( port->a, 4);
	unsigned int b = std2ui( port->b, 4);
	unsigned int d = std2ui( port->d, 4);
	unsigned int i = std2ui( port->i, 9);
	unsigned int cin = std2ui( &(port->cin), 1);

	unsigned int q0;
	unsigned int r0;
	unsigned int q3;
	unsigned int r3;

	switch (i & 0x7)
		{
		case 0 :
			r = ram[a];
			s = accu;
			break;
		case 1 :
			r = ram[a];
			s = ram[b];
			break;
		case 2 :
			r = 0;
			s = accu;
			break;
		case 3 :
			r = 0;
			s = ram[b];
			break;
		case 4 :
			r = 0;
			s = ram[a];
			break;
		case 5 :
			r = d;
			s = ram[a];
			break;
		case 6 :
			r = d;
			s = accu;
			break;
		case 7 :
			r = d;
			s = 0;
		}

	switch ((i >> 3) & 0x7)
		{
		case 0 :
			alu_out = r + s + cin;
			break;
		case 1 :
			alu_out = (cin)? s - r : s - r - 1;
			break;
		case 2 :
			alu_out = (cin)? r - s : r - s - 1;
			break;
		case 3 :
			alu_out = r | s;
			break;
		case 4 :
			alu_out = r & s;
			break;
		case 5 :
			alu_out = (~r) & s;
			break;
		case 6 :
			alu_out = r ^ s;
			break;
		case 7 :
			alu_out = ~(r ^ s);
		}
	alu_out &= 0xF;

	if (port->noe == STD_1) slv_setv(port->y, 4, "%s", "ZZZZ");
	else
		{
		if (((i >> 6) & 0x7) == 2) slv_setv(port->y, 4, "%u", ram[a]);
		else slv_setv(port->y, 4, "%u", alu_out);
		}

	switch ((i >> 6) & 0x7)
		{
		case 0 :
			accu = alu_out & 0xf;
			break;
		case 2 :
		case 3 :
			ram[b] = alu_out & 0xf;
			break;
		case 4 :
			q3 = std2ui( &(port->q3), 1);
			accu = ((accu >> 1) | (q3 << 3)) & 0xf;
		case 5 :
			r3 = std2ui( &(port->r3), 1);
			ram[b] = ((alu_out >> 1) | (r3 << 3)) & 0xf;
			break;
		case 6 :
			q0 = std2ui( &(port->q0), 1);
			accu = ((accu << 1) | q0) & 0xf;
		case 7 :
			r0 = std2ui( &(port->r0), 1);
			ram[b] = ((alu_out << 1) | r0) & 0xf;
		}
	//return out;
	}
