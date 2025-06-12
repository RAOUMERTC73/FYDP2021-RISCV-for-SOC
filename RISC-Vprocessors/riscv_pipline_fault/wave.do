onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/clk
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/rst
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/PCSrcE
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/StallF
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/StallD
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/FlushD
add wave -noupdate -expand -group fetch_cycle /top_tb/dut/fetch_cycle_inst/PCTargetE
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/InstrD
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/PCD
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/PCPlus4D
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/PC_F
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/PCF
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/PCPlus4F
add wave -noupdate -expand -group fetch_cycle -radix hexadecimal /top_tb/dut/fetch_cycle_inst/InstrF
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/clk
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/rst
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RegWriteW
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/FlushE
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/ImmSrcD
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RdW
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/InstrD
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/PCD
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/PCPlus4D
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/ResultW
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RD1_E
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RD2_E
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/ImmExtE
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/Rs1E
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/Rs2E
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RdE
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/PCE
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/PCPlus4E
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RD1_D
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/RD2_D
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/ImmExtD
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/Rs1D
add wave -noupdate -expand -group decode_cycle /top_tb/dut/decode_cycle_inst/Rs2D
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/clk
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/rst
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ALUSrcE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ALUControlE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/RD1_E
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/RD2_E
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ImmExtE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/PCE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/PCPlus4E
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ResultW
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ForwardAE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ForwardBE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/RdE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ZeroE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/RdM
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/PCPlus4M
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/WriteDataM
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ALUResultM
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/PCTargetE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/SrcAE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/WriteDataE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/SrcBE
add wave -noupdate -expand -group execute_cycle /top_tb/dut/execute_cycle_inst/ALUResultE
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/clk
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/rst
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/MemWriteM
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/RdM
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/PCPlus4M
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/WriteDataM
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/ALUResultM
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/RdW
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/PCPlus4W
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/ALUResultW
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/ReadDataW
add wave -noupdate -expand -group memory_cycle /top_tb/dut/memory_cycle_inst/ReadDataM
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/clk
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/rst
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/ResultSrcW
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/PCPlus4W
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/ALUResultW
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/ReadDataW
add wave -noupdate -expand -group writeback_cycle /top_tb/dut/writeback_cycle_inst/ResultW
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/Rs1D
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/Rs2D
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/Rs1E
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/Rs2E
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/RdE
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/RdM
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/RdW
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/PCSrcE
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/ResultSrcEbO
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/RegWriteM
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/RegWriteW
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/ForwardAE
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/ForwardBE
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/StallF
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/StallD
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/FlushD
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/FlushE
add wave -noupdate -expand -group hazard /top_tb/dut/hazard_inst/lwStallD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39 ps} 0}
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
WaveRestoreZoom {0 ps} {192 ps}
