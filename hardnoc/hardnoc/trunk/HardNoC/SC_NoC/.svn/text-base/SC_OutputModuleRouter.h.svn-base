#ifndef OUTMODULEROUTER
#define OUTMODULEROUTER

#define constFlitSize 16
#define constNumPort 4
#define constNumRot 6
#define constNumRotX 2
#define constNumRotY 3
#define constNumVC 2

#include "systemc.h"
#include <stdio.h>
#include <string.h>

SC_MODULE(outmodulerouter)
{
	sc_in<sc_logic> clock;
	sc_in<sc_logic> reset;
	sc_in<sc_logic> tx_r0p0;
	sc_in<sc_logic> lane_tx_r0p0l0;
	sc_in<sc_logic> lane_tx_r0p0l1;
	sc_in<sc_lv<constFlitSize> > out_r0p0;
	sc_in<sc_logic> credit_ir0p0l0;
	sc_in<sc_logic> credit_ir0p0l1;
	sc_in<sc_logic> tx_r0p2;
	sc_in<sc_logic> lane_tx_r0p2l0;
	sc_in<sc_logic> lane_tx_r0p2l1;
	sc_in<sc_lv<constFlitSize> > out_r0p2;
	sc_in<sc_logic> credit_ir0p2l0;
	sc_in<sc_logic> credit_ir0p2l1;
	sc_in<sc_logic> tx_r1p1;
	sc_in<sc_logic> lane_tx_r1p1l0;
	sc_in<sc_logic> lane_tx_r1p1l1;
	sc_in<sc_lv<constFlitSize> > out_r1p1;
	sc_in<sc_logic> credit_ir1p1l0;
	sc_in<sc_logic> credit_ir1p1l1;
	sc_in<sc_logic> tx_r1p2;
	sc_in<sc_logic> lane_tx_r1p2l0;
	sc_in<sc_logic> lane_tx_r1p2l1;
	sc_in<sc_lv<constFlitSize> > out_r1p2;
	sc_in<sc_logic> credit_ir1p2l0;
	sc_in<sc_logic> credit_ir1p2l1;
	sc_in<sc_logic> tx_r2p0;
	sc_in<sc_logic> lane_tx_r2p0l0;
	sc_in<sc_logic> lane_tx_r2p0l1;
	sc_in<sc_lv<constFlitSize> > out_r2p0;
	sc_in<sc_logic> credit_ir2p0l0;
	sc_in<sc_logic> credit_ir2p0l1;
	sc_in<sc_logic> tx_r2p2;
	sc_in<sc_logic> lane_tx_r2p2l0;
	sc_in<sc_logic> lane_tx_r2p2l1;
	sc_in<sc_lv<constFlitSize> > out_r2p2;
	sc_in<sc_logic> credit_ir2p2l0;
	sc_in<sc_logic> credit_ir2p2l1;
	sc_in<sc_logic> tx_r2p3;
	sc_in<sc_logic> lane_tx_r2p3l0;
	sc_in<sc_logic> lane_tx_r2p3l1;
	sc_in<sc_lv<constFlitSize> > out_r2p3;
	sc_in<sc_logic> credit_ir2p3l0;
	sc_in<sc_logic> credit_ir2p3l1;
	sc_in<sc_logic> tx_r3p1;
	sc_in<sc_logic> lane_tx_r3p1l0;
	sc_in<sc_logic> lane_tx_r3p1l1;
	sc_in<sc_lv<constFlitSize> > out_r3p1;
	sc_in<sc_logic> credit_ir3p1l0;
	sc_in<sc_logic> credit_ir3p1l1;
	sc_in<sc_logic> tx_r3p2;
	sc_in<sc_logic> lane_tx_r3p2l0;
	sc_in<sc_logic> lane_tx_r3p2l1;
	sc_in<sc_lv<constFlitSize> > out_r3p2;
	sc_in<sc_logic> credit_ir3p2l0;
	sc_in<sc_logic> credit_ir3p2l1;
	sc_in<sc_logic> tx_r3p3;
	sc_in<sc_logic> lane_tx_r3p3l0;
	sc_in<sc_logic> lane_tx_r3p3l1;
	sc_in<sc_lv<constFlitSize> > out_r3p3;
	sc_in<sc_logic> credit_ir3p3l0;
	sc_in<sc_logic> credit_ir3p3l1;
	sc_in<sc_logic> tx_r4p0;
	sc_in<sc_logic> lane_tx_r4p0l0;
	sc_in<sc_logic> lane_tx_r4p0l1;
	sc_in<sc_lv<constFlitSize> > out_r4p0;
	sc_in<sc_logic> credit_ir4p0l0;
	sc_in<sc_logic> credit_ir4p0l1;
	sc_in<sc_logic> tx_r4p3;
	sc_in<sc_logic> lane_tx_r4p3l0;
	sc_in<sc_logic> lane_tx_r4p3l1;
	sc_in<sc_lv<constFlitSize> > out_r4p3;
	sc_in<sc_logic> credit_ir4p3l0;
	sc_in<sc_logic> credit_ir4p3l1;
	sc_in<sc_logic> tx_r5p1;
	sc_in<sc_logic> lane_tx_r5p1l0;
	sc_in<sc_logic> lane_tx_r5p1l1;
	sc_in<sc_lv<constFlitSize> > out_r5p1;
	sc_in<sc_logic> credit_ir5p1l0;
	sc_in<sc_logic> credit_ir5p1l1;
	sc_in<sc_logic> tx_r5p3;
	sc_in<sc_logic> lane_tx_r5p3l0;
	sc_in<sc_logic> lane_tx_r5p3l1;
	sc_in<sc_lv<constFlitSize> > out_r5p3;
	sc_in<sc_logic> credit_ir5p3l0;
	sc_in<sc_logic> credit_ir5p3l1;

	int inline inTx(int Roteador, int Porta){
		if (Roteador == 0){
				if(Porta == 0) return (tx_r0p0==SC_LOGIC_1)? 1 : 0;
				if(Porta == 2) return (tx_r0p2==SC_LOGIC_1)? 1 : 0;
		}
		else if (Roteador == 1){
				if(Porta == 1) return (tx_r1p1==SC_LOGIC_1)? 1 : 0;
				if(Porta == 2) return (tx_r1p2==SC_LOGIC_1)? 1 : 0;
		}
		else if (Roteador == 2){
				if(Porta == 0) return (tx_r2p0==SC_LOGIC_1)? 1 : 0;
				if(Porta == 2) return (tx_r2p2==SC_LOGIC_1)? 1 : 0;
				if(Porta == 3) return (tx_r2p3==SC_LOGIC_1)? 1 : 0;
		}
		else if (Roteador == 3){
				if(Porta == 1) return (tx_r3p1==SC_LOGIC_1)? 1 : 0;
				if(Porta == 2) return (tx_r3p2==SC_LOGIC_1)? 1 : 0;
				if(Porta == 3) return (tx_r3p3==SC_LOGIC_1)? 1 : 0;
		}
		else if (Roteador == 4){
				if(Porta == 0) return (tx_r4p0==SC_LOGIC_1)? 1 : 0;
				if(Porta == 3) return (tx_r4p3==SC_LOGIC_1)? 1 : 0;
		}
		else if (Roteador == 5){
				if(Porta == 1) return (tx_r5p1==SC_LOGIC_1)? 1 : 0;
				if(Porta == 3) return (tx_r5p3==SC_LOGIC_1)? 1 : 0;
		}
	}

	int inline inLaneTx(int Roteador,int Porta, int Canal){
		if (Roteador == 0){
			if (Porta == 0){
				if(Canal == 0) return (lane_tx_r0p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r0p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (lane_tx_r0p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r0p2l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 1){
			if (Porta == 1){
				if(Canal == 0) return (lane_tx_r1p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r1p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (lane_tx_r1p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r1p2l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 2){
			if (Porta == 0){
				if(Canal == 0) return (lane_tx_r2p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r2p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (lane_tx_r2p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r2p2l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (lane_tx_r2p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r2p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 3){
			if (Porta == 1){
				if(Canal == 0) return (lane_tx_r3p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r3p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (lane_tx_r3p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r3p2l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (lane_tx_r3p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r3p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 4){
			if (Porta == 0){
				if(Canal == 0) return (lane_tx_r4p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r4p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (lane_tx_r4p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r4p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 5){
			if (Porta == 1){
				if(Canal == 0) return (lane_tx_r5p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r5p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (lane_tx_r5p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (lane_tx_r5p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
	}

	unsigned long inline inData(int Roteador, int Porta){
		if(Roteador == 0){
			if(Porta == 0) return out_r0p0.read().to_uint();
			if(Porta == 2) return out_r0p2.read().to_uint();
		}
		else if(Roteador == 1){
			if(Porta == 1) return out_r1p1.read().to_uint();
			if(Porta == 2) return out_r1p2.read().to_uint();
		}
		else if(Roteador == 2){
			if(Porta == 0) return out_r2p0.read().to_uint();
			if(Porta == 2) return out_r2p2.read().to_uint();
			if(Porta == 3) return out_r2p3.read().to_uint();
		}
		else if(Roteador == 3){
			if(Porta == 1) return out_r3p1.read().to_uint();
			if(Porta == 2) return out_r3p2.read().to_uint();
			if(Porta == 3) return out_r3p3.read().to_uint();
		}
		else if(Roteador == 4){
			if(Porta == 0) return out_r4p0.read().to_uint();
			if(Porta == 3) return out_r4p3.read().to_uint();
		}
		else if(Roteador == 5){
			if(Porta == 1) return out_r5p1.read().to_uint();
			if(Porta == 3) return out_r5p3.read().to_uint();
		}
	}

	int inline inCredit(int Roteador, int Porta, int Canal){
		if (Roteador == 0){
			if (Porta == 0){
				if(Canal == 0) return (credit_ir0p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir0p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (credit_ir0p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir0p2l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 1){
			if (Porta == 1){
				if(Canal == 0) return (credit_ir1p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir1p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (credit_ir1p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir1p2l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 2){
			if (Porta == 0){
				if(Canal == 0) return (credit_ir2p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir2p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (credit_ir2p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir2p2l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (credit_ir2p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir2p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 3){
			if (Porta == 1){
				if(Canal == 0) return (credit_ir3p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir3p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 2){
				if(Canal == 0) return (credit_ir3p2l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir3p2l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (credit_ir3p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir3p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 4){
			if (Porta == 0){
				if(Canal == 0) return (credit_ir4p0l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir4p0l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (credit_ir4p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir4p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
		else if (Roteador == 5){
			if (Porta == 1){
				if(Canal == 0) return (credit_ir5p1l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir5p1l1==SC_LOGIC_1)? 1 : 0;
			}
			if (Porta == 3){
				if(Canal == 0) return (credit_ir5p3l0==SC_LOGIC_1)? 1 : 0;
				if(Canal == 1) return (credit_ir5p3l1==SC_LOGIC_1)? 1 : 0;
			}
		}
	}

	unsigned long int CurrentTime;

	void inline TrafficWatcher();
	void inline Timer();
	void inline port_assign();

	SC_CTOR(outmodulerouter) :
	tx_r0p0("tx_r0p0"),
	lane_tx_r0p0l0("lane_tx_r0p0l0"),
	lane_tx_r0p0l1("lane_tx_r0p0l1"),
	out_r0p0("out_r0p0"),
	credit_ir0p0l0("credit_ir0p0l0"),
	credit_ir0p0l1("credit_ir0p0l1"),
	tx_r0p2("tx_r0p2"),
	lane_tx_r0p2l0("lane_tx_r0p2l0"),
	lane_tx_r0p2l1("lane_tx_r0p2l1"),
	out_r0p2("out_r0p2"),
	credit_ir0p2l0("credit_ir0p2l0"),
	credit_ir0p2l1("credit_ir0p2l1"),
	tx_r1p1("tx_r1p1"),
	lane_tx_r1p1l0("lane_tx_r1p1l0"),
	lane_tx_r1p1l1("lane_tx_r1p1l1"),
	out_r1p1("out_r1p1"),
	credit_ir1p1l0("credit_ir1p1l0"),
	credit_ir1p1l1("credit_ir1p1l1"),
	tx_r1p2("tx_r1p2"),
	lane_tx_r1p2l0("lane_tx_r1p2l0"),
	lane_tx_r1p2l1("lane_tx_r1p2l1"),
	out_r1p2("out_r1p2"),
	credit_ir1p2l0("credit_ir1p2l0"),
	credit_ir1p2l1("credit_ir1p2l1"),
	tx_r2p0("tx_r2p0"),
	lane_tx_r2p0l0("lane_tx_r2p0l0"),
	lane_tx_r2p0l1("lane_tx_r2p0l1"),
	out_r2p0("out_r2p0"),
	credit_ir2p0l0("credit_ir2p0l0"),
	credit_ir2p0l1("credit_ir2p0l1"),
	tx_r2p2("tx_r2p2"),
	lane_tx_r2p2l0("lane_tx_r2p2l0"),
	lane_tx_r2p2l1("lane_tx_r2p2l1"),
	out_r2p2("out_r2p2"),
	credit_ir2p2l0("credit_ir2p2l0"),
	credit_ir2p2l1("credit_ir2p2l1"),
	tx_r2p3("tx_r2p3"),
	lane_tx_r2p3l0("lane_tx_r2p3l0"),
	lane_tx_r2p3l1("lane_tx_r2p3l1"),
	out_r2p3("out_r2p3"),
	credit_ir2p3l0("credit_ir2p3l0"),
	credit_ir2p3l1("credit_ir2p3l1"),
	tx_r3p1("tx_r3p1"),
	lane_tx_r3p1l0("lane_tx_r3p1l0"),
	lane_tx_r3p1l1("lane_tx_r3p1l1"),
	out_r3p1("out_r3p1"),
	credit_ir3p1l0("credit_ir3p1l0"),
	credit_ir3p1l1("credit_ir3p1l1"),
	tx_r3p2("tx_r3p2"),
	lane_tx_r3p2l0("lane_tx_r3p2l0"),
	lane_tx_r3p2l1("lane_tx_r3p2l1"),
	out_r3p2("out_r3p2"),
	credit_ir3p2l0("credit_ir3p2l0"),
	credit_ir3p2l1("credit_ir3p2l1"),
	tx_r3p3("tx_r3p3"),
	lane_tx_r3p3l0("lane_tx_r3p3l0"),
	lane_tx_r3p3l1("lane_tx_r3p3l1"),
	out_r3p3("out_r3p3"),
	credit_ir3p3l0("credit_ir3p3l0"),
	credit_ir3p3l1("credit_ir3p3l1"),
	tx_r4p0("tx_r4p0"),
	lane_tx_r4p0l0("lane_tx_r4p0l0"),
	lane_tx_r4p0l1("lane_tx_r4p0l1"),
	out_r4p0("out_r4p0"),
	credit_ir4p0l0("credit_ir4p0l0"),
	credit_ir4p0l1("credit_ir4p0l1"),
	tx_r4p3("tx_r4p3"),
	lane_tx_r4p3l0("lane_tx_r4p3l0"),
	lane_tx_r4p3l1("lane_tx_r4p3l1"),
	out_r4p3("out_r4p3"),
	credit_ir4p3l0("credit_ir4p3l0"),
	credit_ir4p3l1("credit_ir4p3l1"),
	tx_r5p1("tx_r5p1"),
	lane_tx_r5p1l0("lane_tx_r5p1l0"),
	lane_tx_r5p1l1("lane_tx_r5p1l1"),
	out_r5p1("out_r5p1"),
	credit_ir5p1l0("credit_ir5p1l0"),
	credit_ir5p1l1("credit_ir5p1l1"),
	tx_r5p3("tx_r5p3"),
	lane_tx_r5p3l0("lane_tx_r5p3l0"),
	lane_tx_r5p3l1("lane_tx_r5p3l1"),
	out_r5p3("out_r5p3"),
	credit_ir5p3l0("credit_ir5p3l0"),
	credit_ir5p3l1("credit_ir5p3l1"),
	reset("reset"),
	clock("clock")
	{
		CurrentTime = 0;

		SC_CTHREAD(TrafficWatcher, clock.pos());
		watching(reset.delayed()== true);

		SC_METHOD(Timer);
		sensitive_pos << clock;
		dont_initialize();
	}
};

void inline outmodulerouter::Timer(){
	++CurrentTime;
}

void inline outmodulerouter::TrafficWatcher(){
	char temp[100];
	FILE* Output[constNumRot][constNumPort][constNumVC];
	unsigned long int cont[constNumRot][constNumPort][constNumVC];
	unsigned long int size[constNumRot][constNumPort][constNumVC];
	unsigned long int currentFlit[constNumRot][constNumPort][constNumVC];
	int rot,port,lane;

	for(rot=0;rot<constNumRot;rot++){
		//roteador não é o limite da direita, logo tem a porta EAST
 		if((rot%constNumRotX)!=(constNumRotX-1)){
			for(lane=0;lane<constNumVC;lane++){
				sprintf(temp, "r%dp0l%d.txt", rot,lane);
				Output[rot][0][lane] = fopen(temp, "w");
				cont[rot][0][lane] = 0;
			}
		}
		//roteador não é o limite da esquerda, logo tem a porta WEST
 		if((rot%constNumRotX)!=0){
			for(lane=0;lane<constNumVC;lane++){
				sprintf(temp, "r%dp1l%d.txt", rot,lane);
				Output[rot][1][lane] = fopen(temp, "w");
				cont[rot][1][lane] = 0;
			}
		}
		//roteador não é o limite superior, logo tem a porta NORTH
 		if((rot/constNumRotX)!=(constNumRotY-1)){
			for(lane=0;lane<constNumVC;lane++){
				sprintf(temp, "r%dp2l%d.txt", rot,lane);
				Output[rot][2][lane] = fopen(temp, "w");
				cont[rot][2][lane] = 0;
			}
		}
		//roteador não é o limite inferior, logo tem a porta SOUTH
 		if((rot/constNumRotX)!=0){
			for(lane=0;lane<constNumVC;lane++){
				sprintf(temp, "r%dp3l%d.txt", rot,lane);
				Output[rot][3][lane] = fopen(temp, "w");
				cont[rot][3][lane] = 0;
			}
		}
	}

	while(true){
		for(rot=0;rot<constNumRot;rot++){

			//roteador não é o limite da direita, logo tem a porta EAST
			if((rot%constNumRotX)!=(constNumRotX-1)){
				for(lane=0;lane<constNumVC;lane++){
					if(inTx(rot,0) == 1 && inLaneTx(rot,0,lane) == 1 && inCredit(rot,0,lane)==1){
						currentFlit[rot][0][lane] = inData(rot,0);
						fprintf(Output[rot][0][lane], "(%0*X %u)", (int)constFlitSize/4, currentFlit[rot][0][lane], CurrentTime);
						cont[rot][0][lane]++;

						if(cont[rot][0][lane] == 2)
							size[rot][0][lane] = currentFlit[rot][0][lane] + 2;

						if(cont[rot][0][lane]>2 && cont[rot][0][lane]==size[rot][0][lane]){
							fprintf(Output[rot][0][lane], "\n");
							cont[rot][0][lane]=0;
							size[rot][0][lane]=0;
						}
					}
				}
			}
			//roteador não é o limite da esquerda, logo tem a porta WEST
			if((rot%constNumRotX)!=0){
				for(lane=0;lane<constNumVC;lane++){
					if(inTx(rot,1) == 1 && inLaneTx(rot,1,lane) == 1 && inCredit(rot,1,lane)==1){
						currentFlit[rot][1][lane] = inData(rot,1);
						fprintf(Output[rot][1][lane], "(%0*X %u)", (int)constFlitSize/4, currentFlit[rot][1][lane], CurrentTime);
						cont[rot][1][lane]++;

						if(cont[rot][1][lane] == 2)
							size[rot][1][lane] = currentFlit[rot][1][lane] + 2;

						if(cont[rot][1][lane]>2 && cont[rot][1][lane]==size[rot][1][lane]){
							fprintf(Output[rot][1][lane], "\n");
							cont[rot][1][lane]=0;
							size[rot][1][lane]=0;
						}
					}
				}
			}
			//roteador não é o limite superior, logo tem a porta NORTH
			if((rot/constNumRotX)!=constNumRotY-1){
				for(lane=0;lane<constNumVC;lane++){
					if(inTx(rot,2) == 1 && inLaneTx(rot,2,lane) == 1 && inCredit(rot,2,lane)==1){
						currentFlit[rot][2][lane] = inData(rot,2);
						fprintf(Output[rot][2][lane], "(%0*X %u)", (int)constFlitSize/4, currentFlit[rot][2][lane], CurrentTime);
						cont[rot][2][lane]++;

						if(cont[rot][2][lane] == 2)
							size[rot][2][lane] = currentFlit[rot][2][lane] + 2;

						if(cont[rot][2][lane]>2 && cont[rot][2][lane]==size[rot][2][lane]){
							fprintf(Output[rot][2][lane], "\n");
							cont[rot][2][lane]=0;
							size[rot][2][lane]=0;
						}
					}
				}
			}
			//roteador não é o limite inferior, logo tem a porta SOUTH
			if((rot/constNumRotX)!=0){
				for(lane=0;lane<constNumVC;lane++){
					if(inTx(rot,3) == 1 && inLaneTx(rot,3,lane) == 1 && inCredit(rot,3,lane)==1){
						currentFlit[rot][3][lane] = inData(rot,3);
						fprintf(Output[rot][3][lane], "(%0*X %u)", (int)constFlitSize/4, currentFlit[rot][3][lane], CurrentTime);
						cont[rot][3][lane]++;

						if(cont[rot][3][lane] == 2)
							size[rot][3][lane] = currentFlit[rot][3][lane] + 2;

						if(cont[rot][3][lane]>2 && cont[rot][3][lane]==size[rot][3][lane]){
							fprintf(Output[rot][3][lane], "\n");
							cont[rot][3][lane]=0;
							size[rot][3][lane]=0;
						}
					}
				}
			}
		}
		wait();
	}
}

#endif //OUTMODULEROUTER
