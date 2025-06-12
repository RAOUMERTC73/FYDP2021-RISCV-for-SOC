onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {GLOBAL INPUTS} /tb/clk
add wave -noupdate -expand -group {GLOBAL INPUTS} /tb/rst
add wave -noupdate -expand -group {fetch cycle} /tb/dut/Fetch/PCSrcE
add wave -noupdate -expand -group {fetch cycle} /tb/dut/Fetch/PCTargetE
add wave -noupdate -expand -group {fetch cycle} /tb/dut/Fetch/InstrD
add wave -noupdate -expand -group {fetch cycle} /tb/dut/Fetch/PCD
add wave -noupdate -expand -group {fetch cycle} /tb/dut/Fetch/PCPlus4D
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/RegWriteE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/ALUSrcE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/MemWriteE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/ResultSrcE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/BranchE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/ALUControlE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/RD1_E
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/RD2_E
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/Imm_Ext_E
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/RD_E
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/PCE
add wave -noupdate -expand -group {decode cyce} /tb/dut/Decode/PCPlus4E
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/RegWriteM
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/MemWriteM
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/ResultSrcM
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/RD_M
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/PCPlus4M
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/WriteDataM
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/ALU_ResultM
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/Src_A
add wave -noupdate -expand -group {execute cycle} /tb/dut/Execute/Src_B
add wave -noupdate -expand -group {memory } /tb/dut/Memory/ResultSrcW
add wave -noupdate -expand -group {memory } /tb/dut/Memory/PCPlus4W
add wave -noupdate -expand -group {memory } /tb/dut/Memory/ALU_ResultW
add wave -noupdate -expand -group {memory } /tb/dut/Memory/ReadDataW
add wave -noupdate -expand -group {register writeback} -radix hexadecimal /tb/dut/Memory/RegWriteW
add wave -noupdate -expand -group {register writeback} -radix hexadecimal /tb/dut/WriteBack/ResultW
add wave -noupdate -expand -group {register writeback} -radix hexadecimal /tb/dut/Decode/RDW
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/RegWriteM
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/RegWriteW
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/RD_M
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/RD_W
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/Rs1_E
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/Rs2_E
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/ForwardAE
add wave -noupdate -expand -group {forwarding block} /tb/dut/Forwarding_block/ForwardBE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {250 ps} {1250 ps}
