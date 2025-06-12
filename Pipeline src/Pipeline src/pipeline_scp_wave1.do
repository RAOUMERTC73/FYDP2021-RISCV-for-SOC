onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {GLOBAL INPUTS} /tb/clk
add wave -noupdate -expand -group {GLOBAL INPUTS} /tb/rst
add wave -noupdate -expand -group {fetch cycle} -color Aquamarine -radix hexadecimal /tb/dut/Fetch/PCSrcE
add wave -noupdate -expand -group {fetch cycle} -color Aquamarine -radix hexadecimal /tb/dut/Fetch/PCTargetE
add wave -noupdate -expand -group {fetch cycle} -color Aquamarine -radix hexadecimal /tb/dut/Fetch/InstrD
add wave -noupdate -expand -group {fetch cycle} -color Aquamarine -radix hexadecimal /tb/dut/Fetch/PCD
add wave -noupdate -expand -group {fetch cycle} -color Aquamarine -radix hexadecimal /tb/dut/Fetch/PCPlus4D
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/RegWriteE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/ALUSrcE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/MemWriteE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/ResultSrcE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/BranchE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/ALUControlE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/RD1_E
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/RD2_E
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/Imm_Ext_E
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/RD_E
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/PCE
add wave -noupdate -expand -group {decode cyce} -color Gold -radix hexadecimal /tb/dut/Decode/PCPlus4E
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/RegWriteM
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/MemWriteM
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/ResultSrcM
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/RD_M
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/PCPlus4M
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/WriteDataM
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/ALU_ResultM
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/Src_A
add wave -noupdate -expand -group {execute cycle} -color {Cornflower Blue} -radix hexadecimal /tb/dut/Execute/Src_B
add wave -noupdate -expand -group {memory } -radix hexadecimal /tb/dut/Memory/ResultSrcW
add wave -noupdate -expand -group {memory } -radix hexadecimal -childformat {{{/tb/dut/Memory/PCPlus4W[31]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[30]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[29]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[28]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[27]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[26]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[25]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[24]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[23]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[22]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[21]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[20]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[19]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[18]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[17]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[16]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[15]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[14]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[13]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[12]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[11]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[10]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[9]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[8]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[7]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[6]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[5]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[4]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[3]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[2]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[1]} -radix hexadecimal} {{/tb/dut/Memory/PCPlus4W[0]} -radix hexadecimal}} -subitemconfig {{/tb/dut/Memory/PCPlus4W[31]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[30]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[29]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[28]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[27]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[26]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[25]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[24]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[23]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[22]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[21]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[20]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[19]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[18]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[17]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[16]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[15]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[14]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[13]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[12]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[11]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[10]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[9]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[8]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[7]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[6]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[5]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[4]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[3]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[2]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[1]} {-radix hexadecimal} {/tb/dut/Memory/PCPlus4W[0]} {-radix hexadecimal}} /tb/dut/Memory/PCPlus4W
add wave -noupdate -expand -group {memory } -radix hexadecimal /tb/dut/Memory/ALU_ResultW
add wave -noupdate -expand -group {memory } -radix hexadecimal /tb/dut/Memory/ReadDataW
add wave -noupdate -expand -group {register writeback} -radix hexadecimal /tb/dut/Memory/RegWriteW
add wave -noupdate -expand -group {register writeback} -color Blue -radix hexadecimal /tb/dut/WriteBack/ResultW
add wave -noupdate -expand -group {register writeback} -color Gold -radix hexadecimal /tb/dut/Decode/RDW
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/RegWriteM
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/RegWriteW
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/RD_M
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/RD_W
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/Rs1_E
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/Rs2_E
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/ForwardAE
add wave -noupdate -expand -group {forwarding block} -color {Medium Orchid} -radix hexadecimal /tb/dut/Forwarding_block/ForwardBE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {54 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1260 ps}
