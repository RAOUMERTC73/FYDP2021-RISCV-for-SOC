.main clear;
vlog uart_top.sv uart_top_tb.sv;
vlog ../uart_transmitter/uart_tx.sv ../uart_transmitter/uart_tx_tb.sv;
vlog ../uart_receiver/uart_rx.sv ../uart_receiver/uart_rx_tb.sv;
vsim work.uart_top_tb;
add wave -position insertpoint sim:/uart_top_tb/*;
add wave -position insertpoint sim:/uart_top_tb/uart_top/*;
run -a;
wave zoom full;