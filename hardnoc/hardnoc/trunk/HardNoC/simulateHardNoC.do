# project path
cd /home2/ricardo/Documents/Projects/hardnoc/HardNoC/HardNoC

vlib work
vmap work work

#unisim path
vmap unisim /home2/ricardo/Documents/Libraries/unisim

vcom -work work -93 -explicit dcm.vhd
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
vcom -work work -93 -explicit NOC/RouterTC.vhd
vcom -work work -93 -explicit NOC/RouterBC.vhd
vcom -work work -93 -explicit NOC/NOC.vhd
vcom -work work -93 -explicit IPs/SerialInterface.vhd
vcom -work work -93 -explicit IPs/Serial.vhd
vcom -work work -93 -explicit IPs/Tester.vhd
vcom -work work -93 -explicit HardNoC.vhd
vcom -work work -93 -explicit HardNoC_TB.vhd

vsim -t ps work.HardNoC_TB
#set StdArithNoWarnings 1
#run 20 ms
#quit -f
