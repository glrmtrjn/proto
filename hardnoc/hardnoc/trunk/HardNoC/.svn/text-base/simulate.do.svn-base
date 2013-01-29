cd "C:/alinev/HardNoCProjects/Teste"

vlib work
vmap work work

sccom -g SC_NoC/SC_InputModule.cpp
sccom -g SC_NoC/SC_OutputModule.cpp
sccom -g SC_NoC/SC_OutputModuleRouter.cpp
sccom -link

vcom -work work -93 -explicit NOC/Hermes_package.vhd
vcom -work work -93 -explicit NOC/Hermes_buffer.vhd
vcom -work work -93 -explicit NOC/Hermes_inport.vhd
vcom -work work -93 -explicit NOC/Hermes_switchcontrol.vhd
vcom -work work -93 -explicit NOC/Hermes_outport.vhd
vcom -work work -93 -explicit NOC/RouterBL.vhd
vcom -work work -93 -explicit NOC/RouterBR.vhd
vcom -work work -93 -explicit NOC/RouterCL.vhd
vcom -work work -93 -explicit NOC/RouterCR.vhd
vcom -work work -93 -explicit NOC/RouterTL.vhd
vcom -work work -93 -explicit NOC/RouterTR.vhd
vcom -work work -93 -explicit NOC/NOC.vhd
vcom -work work -93 -explicit topNoC.vhd
vsim work.topNoC
set StdArithNoWarnings 1
run 1 ms
quit -sim
quit -f
