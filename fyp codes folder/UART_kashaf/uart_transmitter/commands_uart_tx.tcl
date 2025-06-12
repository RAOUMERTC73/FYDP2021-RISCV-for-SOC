.main clear;
vlog uart_tx.sv uart_tx_tb.sv;
vsim work.uart_tx_tb;
add wave -position insertpoint sim:/uart_tx_tb/*;
add wave -position insertpoint sim:/uart_tx_tb/uart_tx_DUT/*;
run -a;
wave zoom full;