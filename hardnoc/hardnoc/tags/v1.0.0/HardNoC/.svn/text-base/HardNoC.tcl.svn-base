# open the project and set project-level properties
project new HardNoC.ise
project set family virtex2p
project set device xc2vp30
project set package ff896
project set speed -7

# add all the source HDLs and ucf
xfile add NoC/Hermes_package.vhd
xfile add NoC/Hermes_buffer.vhd
xfile add NoC/Hermes_inport.vhd
xfile add NoC/Hermes_switchcontrol.vhd
xfile add NoC/Hermes_outport.vhd
xfile add NoC/RouterBL.vhd
xfile add NoC/RouterBR.vhd
xfile add NoC/RouterCL.vhd
xfile add NoC/RouterCR.vhd
xfile add NoC/RouterTL.vhd
xfile add NoC/RouterTR.vhd
xfile add NoC/NOC.vhd
xfile add IPs/SerialInterface.vhd
xfile add IPs/Serial.vhd
xfile add IPs/Tester.vhd
xfile add Dcm.vhd
xfile add HardNoC.vhd
xfile add HardNoC.ucf

# get top
set top HardNoC.vhd

# set batch application options :
# 1. set synthesis optimization goal to speed
#project set "Optimization Goal" Speed
#project set "Optimization Effort" Normal
#project set "Keep Hierarchy" Yes
#project set "FSM Encoding Algorithm" One-Hot
#project set "Max Fanout" 20
#project set "Optimization Strategy (Cover Mode)" Speed

# generate the ngd file
# process run "Generate Programming File" -force rerun_all

# close project
project close
