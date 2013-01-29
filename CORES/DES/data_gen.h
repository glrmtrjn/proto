#include <systemc.h>
#include <iostream>
#include <fstream>
using namespace std;

#define ITERACOES 2048


SC_MODULE (data_gen) {
//Interface:

	sc_in < bool > clk;
	sc_in < bool > cReady;
	sc_in < bool > dReady;
	sc_in < bool > cValid;
	sc_in < bool > dValid;

	sc_in < sc_biguint<64> > cOutput;
	sc_in < sc_biguint<64> > dOutput;	
	
	sc_out < bool > reset;	
	sc_out < bool > loadKey;	
	sc_out < bool > cStart;	
	sc_out < bool > dStart;
	
	sc_out < sc_biguint<64> > cInput;
	sc_out < sc_biguint<64> > dInput;


//

int erros;
sc_biguint<64> chaveGeral, gerado[ITERACOES], cifrado[ITERACOES], decifrado[ITERACOES];
				
	SC_HAS_PROCESS(data_gen);
	data_gen(sc_module_name nm) : 
		sc_module(nm),
		clk("clk"),
		reset("reset"),
		loadKey("loadKey"),
		cStart("cStart"),
		dStart("dStart"),
		cReady("cReady"),
		dReady("dReady"),
		cValid("cValid"),
		dValid("dValid"),		
		cInput("cInput"),
		dInput("dInput"),
		cOutput("cOutput"),
		dOutput("dOutput")

		 {
		 	cout << "\n\n Startin...\n"; 
			SC_THREAD(verifica);
		}
	void novaChave();
	void verifica();	
	void rst();
	void cifra(int);
	int check(int);
	void decifra(int);
	void dump(int);
	sc_biguint<64> ran_state();
};
