onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /testbench/clk
add wave -noupdate -radix binary /testbench/reset
add wave -noupdate -radix hexadecimal /testbench/dut/core/dp/PC
add wave -noupdate -radix hexadecimal /testbench/dut/core/dp/Instr
add wave -noupdate /testbench/dut/core/c/fsm/state
add wave -noupdate -radix hexadecimal /testbench/dut/core/dp/SrcA
add wave -noupdate -radix hexadecimal /testbench/dut/core/dp/SrcB
add wave -noupdate -radix hexadecimal /testbench/dut/core/dp/ALUResult
add wave -noupdate -radix hexadecimal /testbench/dut/DataAdr
add wave -noupdate -radix hexadecimal /testbench/dut/WriteData
add wave -noupdate -radix binary /testbench/dut/MemWrite
add wave -noupdate /testbench/dut/unified_memory/rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {725 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {736 ps}
