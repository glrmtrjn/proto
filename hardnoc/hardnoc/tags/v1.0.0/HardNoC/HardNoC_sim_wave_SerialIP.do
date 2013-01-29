onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -itemcolor Blue /hardnoc_tb/rxd
add wave -noupdate -format Logic -itemcolor Blue /hardnoc_tb/system_clock
add wave -noupdate -format Logic -itemcolor Blue /hardnoc_tb/system_reset
add wave -noupdate -format Logic -itemcolor Blue /hardnoc_tb/txd
add wave -noupdate -color Firebrick -format Literal -itemcolor Firebrick -radix hexadecimal /hardnoc_tb/hn/ip0000/data_in
add wave -noupdate -color Firebrick -format Literal -itemcolor Firebrick -radix hexadecimal /hardnoc_tb/hn/ip0000/data_out
add wave -noupdate -color Firebrick -format Logic -itemcolor Firebrick /hardnoc_tb/hn/ip0000/rx
add wave -noupdate -color Firebrick -format Logic -itemcolor Firebrick /hardnoc_tb/hn/ip0000/tx
add wave -noupdate -format Literal /hardnoc_tb/hn/ip0000/si/rx_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24929404 ps} 0}
configure wave -namecolwidth 216
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {141828096 ps}
