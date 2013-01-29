#include "data_gen.h"


#ifdef MTI_SYSTEMC
// export top level to modelsim
SC_MODULE_EXPORT(data_gen);
#elif defined(NC_SYSTEMC)
// export top level to Cadence Incisive
NCSC_MODULE_EXPORT(data_gen);
#endif

#define zero128b 0x00000000000000000000000000000000


void data_gen::verifica() {
	int i=0;
	int it = ITERACOES;
	
	cout << "\treset\n\nTesting "<< it << " values per key\n";
	rst();
	
	while(!erros){
		
		cout << "\n\n\n\tStarting Test # " << i << "\n\n\n";	
			
		
		
		cout << "\tnew Key \n";
		
		novaChave();
		
		wait(clk.posedge_event());	cout << "\tcrypting\n";		
		cifra(ITERACOES);	
				
		wait(clk.posedge_event());	cout << "\tdecrypting them\n";		
		decifra(ITERACOES);
					
		cout << "\tChecking \n";
		erros= check(ITERACOES);
		
		if(erros) dump(ITERACOES);
		i++;
		cout << "=================================\n";
		wait(clk.posedge_event());	
	}
}

void data_gen::dump(int vezes) {
	int i;
	string nome = "";
	nome = string("ERROR_.txt"); 
	ofstream log;
	log.open(nome.c_str());	
	log << hex << "\n\nchave: " << chaveGeral[1] <<" "<< chaveGeral[2] <<" "<< chaveGeral[3] <<" "<< "\n\n\n";
	for(i=0;i<vezes; i++){
		log << i <<": "<< gerado[i] << "  " << cifrado[i] << "  " << decifrado[i] << "\n";	
	}	
	log.close();
}





void data_gen::rst() {
	reset.write(1);
	loadKey.write(0);
	cStart.write(0);
	dStart.write(0);
	cInput.write(zero128b);
	dInput.write(zero128b);		
	wait(55, SC_NS);
	reset.write(0);
	wait(55, SC_NS);
}


void data_gen::novaChave() {
	int i;
	
	for(i=0;i<3;i++){
		chaveGeral[i] = ran_state();
		cInput.write(chaveGeral[i]);
		dInput.write(chaveGeral[i]);
		loadKey.write(1);
		wait(clk.posedge_event());
	}
	loadKey.write(0);
	wait(cReady.posedge_event());	
}

void data_gen::cifra(int vezes) {
	if(cReady.read()){	// nao faz nada se o circuito nao estiver pronto
		int i,j, randValue;
		i=0;
		j=0;
		randValue = 0;
		
		while(j<vezes){
			randValue = rand();			
			if(i < vezes and randValue%2 == 0){	
				cStart.write(1);
				gerado[i]=ran_state();
				cInput.write(gerado[i]);
				i++;
			}else cStart.write(0);
			if(cValid.read() == 1){
				//cout << hex << ":"<< cOutput.read() << "\n";
				cifrado[j]=cOutput;
				j++;
			}	
			
			wait(clk.posedge_event());	
		}
	}
}

void data_gen::decifra(int vezes) {
	if(cReady.read()){	// nao faz nada se o circuito nao estiver pronto
		int i,j, randValue;
		i=0;
		j=0;
		randValue = 0;
		
		while(j<vezes){
			randValue = rand();	
			if(i < vezes and randValue%2 == 0){
				dStart.write(1);
				dInput.write(cifrado[i]);
				i++;
			} else dStart.write(0);
			if(dValid.read() == 1){
				decifrado[j]=dOutput.read();
				j++;
			}	
			wait(clk.posedge_event());	
		}
	}	
}

int data_gen::check(int vezes) {
	int i, erros=0;
	//cout << hex << "chave: " << chaveGeral << "\n"; 
	for(i=0;i<vezes;i++){
			if(gerado[i] != decifrado[i]){
				erros++;
			}	
	}
	cout << dec << "\tCheck finalizado com " << erros << " erros \n";
	return erros; 
	
}

sc_biguint<64> data_gen::ran_state(){
	int i;
	unsigned char entrada;
	sc_biguint<64> resultado = 0;

	for(i=0;i<8;i++){
		entrada= rand() % 256;
		resultado ^= (sc_biguint<64>)entrada << (i*8); 
	}
	return resultado;
}

