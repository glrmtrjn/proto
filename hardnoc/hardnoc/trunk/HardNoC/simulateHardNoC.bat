copy "Y:\mynt\Desenvolvimentos\HardNoC\HardNoC\HardNoCProjects\Teste\Traffic\Uniform\Serial\in_tb.txt" .
rmdir /s /q work
del modelsim.ini
C:\modeltech_6.4\win32\vsim.exe -c -do simulateHardNoC.do
del in_tb.txt
move out_tb.txt "Y:\mynt\Desenvolvimentos\HardNoC\HardNoC\HardNoCProjects\Teste\Traffic\Uniform\Serial"
exit