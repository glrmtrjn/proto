#ifndef INMODULE
#define INMODULE

#define constFlitSize 16
#define constNumRot 6
#define constNumRotX 2
#define constNumRotY 3
#define constNumLane 2


#define constNumberOfChars 4

#include <stdio.h>
#include <string.h>
#include <systemc.h>

SC_MODULE(inputmodule)
{
	sc_in<sc_logic> clock;
	sc_in<sc_logic> reset;
	sc_out<sc_logic> outclock0;
	sc_out<sc_logic> outtx0;
	sc_out<sc_lv<constNumLane> > lane_tx0;
	sc_out<sc_lv<constFlitSize> > outdata0;
	sc_in<sc_lv<constNumLane> > incredit0;
	sc_out<sc_logic> outclock1;
	sc_out<sc_logic> outtx1;
	sc_out<sc_lv<constNumLane> > lane_tx1;
	sc_out<sc_lv<constFlitSize> > outdata1;
	sc_in<sc_lv<constNumLane> > incredit1;
	sc_out<sc_logic> outclock2;
	sc_out<sc_logic> outtx2;
	sc_out<sc_lv<constNumLane> > lane_tx2;
	sc_out<sc_lv<constFlitSize> > outdata2;
	sc_in<sc_lv<constNumLane> > incredit2;
	sc_out<sc_logic> outclock3;
	sc_out<sc_logic> outtx3;
	sc_out<sc_lv<constNumLane> > lane_tx3;
	sc_out<sc_lv<constFlitSize> > outdata3;
	sc_in<sc_lv<constNumLane> > incredit3;
	sc_out<sc_logic> outclock4;
	sc_out<sc_logic> outtx4;
	sc_out<sc_lv<constNumLane> > lane_tx4;
	sc_out<sc_lv<constFlitSize> > outdata4;
	sc_in<sc_lv<constNumLane> > incredit4;
	sc_out<sc_logic> outclock5;
	sc_out<sc_logic> outtx5;
	sc_out<sc_lv<constNumLane> > lane_tx5;
	sc_out<sc_lv<constFlitSize> > outdata5;
	sc_in<sc_lv<constNumLane> > incredit5;


	void inline outTx(int Indice, int Booleano){
		if(Indice == 0) outtx0 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 1) outtx1 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 2) outtx2 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 3) outtx3 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 4) outtx4 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;
		else if(Indice == 5) outtx5 = (Booleano != 0)? SC_LOGIC_1: SC_LOGIC_0;

	}

	void inline laneTx(int Indice, unsigned long int Valor){
		if(Indice == 0) lane_tx0 = Valor;
		else if(Indice == 1) lane_tx1 = Valor;
		else if(Indice == 2) lane_tx2 = Valor;
		else if(Indice == 3) lane_tx3 = Valor;
		else if(Indice == 4) lane_tx4 = Valor;
		else if(Indice == 5) lane_tx5 = Valor;

	}

	void inline outData(int Indice, unsigned long int Valor){
		if(Indice == 0) outdata0 = Valor;
		else if(Indice == 1) outdata1 = Valor;
		else if(Indice == 2) outdata2 = Valor;
		else if(Indice == 3) outdata3 = Valor;
		else if(Indice == 4) outdata4 = Valor;
		else if(Indice == 5) outdata5 = Valor;

	}

	int inline inCredit(int Indice, int Lane){
		if(Indice == 0){
			if(Lane == 0) return (incredit0.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit0.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}
		if(Indice == 1){
			if(Lane == 0) return (incredit1.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit1.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}
		if(Indice == 2){
			if(Lane == 0) return (incredit2.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit2.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}
		if(Indice == 3){
			if(Lane == 0) return (incredit3.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit3.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}
		if(Indice == 4){
			if(Lane == 0) return (incredit4.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit4.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}
		if(Indice == 5){
			if(Lane == 0) return (incredit5.read().get_bit(0) == SC_LOGIC_1)? 1 : 0;
			if(Lane == 1) return (incredit5.read().get_bit(1) == SC_LOGIC_1)? 1 : 0;
		}

	}

	unsigned long int CurrentTime;

	void inline Timer();
	void inline TrafficGenerator();
	void inline port_assign();

	SC_CTOR(inputmodule):

	outclock0("outclock0"),
	outtx0("outtx0"),
	lane_tx0("lane_tx0"),
	outdata0("outdata0"),
	incredit0("incredit0"),
	outclock1("outclock1"),
	outtx1("outtx1"),
	lane_tx1("lane_tx1"),
	outdata1("outdata1"),
	incredit1("incredit1"),
	outclock2("outclock2"),
	outtx2("outtx2"),
	lane_tx2("lane_tx2"),
	outdata2("outdata2"),
	incredit2("incredit2"),
	outclock3("outclock3"),
	outtx3("outtx3"),
	lane_tx3("lane_tx3"),
	outdata3("outdata3"),
	incredit3("incredit3"),
	outclock4("outclock4"),
	outtx4("outtx4"),
	lane_tx4("lane_tx4"),
	outdata4("outdata4"),
	incredit4("incredit4"),
	outclock5("outclock5"),
	outtx5("outtx5"),
	lane_tx5("lane_tx5"),
	outdata5("outdata5"),
	incredit5("incredit5"),

	reset("reset"),
 	clock("clock")
	{
		CurrentTime = 0;
		SC_CTHREAD(TrafficGenerator, clock.pos());  //uma CTHREAD, comeca a executar na primeira subida de clock e. (por tal razao tem um loop infinito dentro dela)
		watching(reset.delayed() == true); //caso o sinal do reset seja 1, ele volta pro comeco da CTHREAD.

		SC_METHOD(Timer); // pro timer
		sensitive_pos << clock;
		dont_initialize();

		SC_METHOD(port_assign); // pra deixar os sinais sempre atualizados...
		sensitive << clock;
	}
};

void inline inputmodule::port_assign(){
	outclock0 = clock;
	outclock1 = clock;
	outclock2 = clock;
	outclock3 = clock;
	outclock4 = clock;
	outclock5 = clock;

}

void inline inputmodule::Timer(){
	++CurrentTime;
}

void inline inputmodule::TrafficGenerator(){

/*******************************************************************************************************************************************
** pacote BE:
**
**  timestamp   target  size   source  timestamp de saida do nodo  nro de sequencia  timestamp de entrada na rede     payload
**      0        00XX   XXXX    00XX      XXXX XXXX XXXX XXXX         XXXX XXXX          XXXX XXXX XXXX XXXX            XXXX ...
**
********************************************************************************************************************************************/

	enum Estado{S1, S2, S3, S4, FimArquivo};
	Estado EstadoAtual[constNumRot];
	FILE* Input[constNumRot];
	char temp[constFlitSize+1], TimestampNet[constFlitSize/4+1];
	unsigned long int CurrentFlit[constNumRot],Target[constNumRot],Size[constNumRot];
	unsigned long int* BigPacket[constNumRot];
	int FlitNumber[constNumRot], NumberofFlits[constNumRot], WaitTime[constNumRot];
	int Index,i,j,k;

	for(Index=0;Index<constNumRot;Index++){
		sprintf(temp,"in%d.txt",Index);
		Input[Index] = fopen(temp,"r");

		outTx(Index,0);
		laneTx(Index,0);
		outData(Index,0);
		EstadoAtual[Index] = S1;
		FlitNumber[Index] = 0;
	}

	while(true){
		for(Index=0;Index<constNumRot;Index++){
			if(Input[Index] != NULL && !feof(Input[Index]) && reset!=SC_LOGIC_1){
				//captura o tempo para entrada na rede
				if(EstadoAtual[Index] == S1){
						outTx(Index,0);
						laneTx(Index,0);
						outData(Index,0);
						FlitNumber[Index] = 0;
						fscanf(Input[Index],"%X",&CurrentFlit[Index]);
						WaitTime[Index] = CurrentFlit[Index];
						EstadoAtual[Index] = S2;
						if(feof(Input[Index])){
							fclose(Input[Index]);
							outTx(Index,0);
							laneTx(Index,0);
							outData(Index,0);
							EstadoAtual[Index] = FimArquivo;
						}
				}
				//espera até o tempo para entrar na rede
				if(EstadoAtual[Index] == S2){
					if(CurrentTime<WaitTime[Index])
						EstadoAtual[Index]=S2;
					else
						EstadoAtual[Index] = S3;
				}
				if(EstadoAtual[Index]== S3){
					//Captura o target
					fscanf(Input[Index],"%X",&CurrentFlit[Index]);
					Target[Index] = CurrentFlit[Index];
					FlitNumber[Index]++;

					//Captura o size
					fscanf(Input[Index],"%X",&CurrentFlit[Index]);
					Size[Index] = CurrentFlit[Index];
					Size[Index] += 4; //4 = Inserção do timestamp de entrada na rede
					NumberofFlits[Index] = Size[Index] + 2; //2 = header + size
					BigPacket[Index]=(unsigned long int*)calloc( sizeof(unsigned long int) , NumberofFlits[Index]);
					BigPacket[Index][0] = Target[Index];
					BigPacket[Index][1] = Size[Index];
					FlitNumber[Index]++;

					//Captura a origem, o timestamp de saida nodo (4 flits) e o número de sequência
					while(FlitNumber[Index] < 9 ){
						fscanf(Input[Index], "%X", &CurrentFlit[Index]);
						BigPacket[Index][FlitNumber[Index]] = CurrentFlit[Index];
						FlitNumber[Index]++;
					}

					//Insere espaço para o timestamp de entrada na rede (4 flits)
					FlitNumber[Index]+=4;

					//Captura o payload
					while(FlitNumber[Index] < NumberofFlits[Index]){
						fscanf(Input[Index], "%X", &CurrentFlit[Index]);
						BigPacket[Index][FlitNumber[Index]] = CurrentFlit[Index];
						FlitNumber[Index]++;
					}
					EstadoAtual[Index] = S4;
					FlitNumber[Index] = 0;

				}
				//comeca a transmitir os dados
				if(EstadoAtual[Index]==S4 && inCredit(Index,0)==1){
					if(FlitNumber[Index]>=NumberofFlits[Index]){
						outTx(Index,0);
						laneTx(Index,0);
						outData(Index,0);
						EstadoAtual[Index] = S1;
						free(BigPacket[Index]);
					}
					else{
						if(FlitNumber[Index] == 0){
							sprintf(temp, "%0*X",constFlitSize, CurrentTime);
							k = 9; //posição que deve ser inserido o timestamp de entrada na rede
							for(i=0,j=0;i<constFlitSize;i++,j++){
								TimestampNet[j]=temp[i];
								if(j==constFlitSize/4-1){
									sscanf(TimestampNet, "%X", &BigPacket[Index][k]);
									j=-1; //  porque na iteracao seguinte vai aumentar 1.
									k++;
								}
							}
						}

						outTx(Index,1);
						laneTx(Index,1); //Transmite somente pela lane L1
						outData(Index, BigPacket[Index][FlitNumber[Index] ]);
						FlitNumber[Index]++;
					}
				}
				if(EstadoAtual[Index] == FimArquivo){
					outTx(Index,0);
					laneTx(Index,0);
					outData(Index,0);
				}
			}
		}
		wait();
	}
}

#endif// INMODULE
