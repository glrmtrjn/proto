 *** SIMULATION NOTES ***
--------------------------------------------------------------------------------------------------------------
 
This version of HardNoC plataform has 2 input files for simulation using HardNoC_TB.vhd as test bench:

 -> traffic_type0.txt: a simple traffic flow that doesn't create port and virtual channel competition.
 Better for understand the plataform's execution.
 Run 1700us for full simulation.
 
 ASCII art drawn describing the traffic:
 
 ====== ---> =====       ======
 | 01 |      | 11 |      | 21 |
 ====== <--- ======      ====== 
                          |   A
                          V   |
 ======      ====== ---> ======
 | 00 |      | 10 |      | 20 | 
 ======      ======      ======
 
 traffic configuration:
 * 01 -> 11
 * 11 -> 01
 * 10 -> 20
 * 20 -> 21
 * 21 -> 20
 
--------------------------------------------------------------------------------------------------------------
 
 -> traffic_type1.txt: a intense traffic flow that creates port and virtual channel competition.
 Better for test the plataform against extreme conditions.
 Run 25ms for full simulation.
 
 ASCII art drawn describing the traffic:
 
 ====== ---> ====== <--- ======
 | 01 |      | 11 |      | 21 |
 ======      ====== ---> ====== 
             A || A         
             | VV |         
 ======      ====== <--- ======
 | 00 |      | 10 |      | 20 | 
 ======      ======      ======
 
 traffic configuration:
 * 01 -> 10
 * 21 -> 10
 * 11 -> 21
 * 10 -> 11
 * 20 -> 11
 
 01->10 (CV0) vs 21->10 (CV1): create competition in routers 11 and 10 (in port level).
 10->11 (CV0) vs 20->11 (CV0): create competition in routers 10 and 11 (in port level).
 
 --------------------------------------------------------------------------------------------------------------
 
 Access the .txt files for more trafffic parameters.
 If you want to change your input file, access HardNoC_TB.vhd and set the name's file on line 12.
 Using Modelsim, there's a .do file in main directory for simulation example (simulateHardNoC.do)
