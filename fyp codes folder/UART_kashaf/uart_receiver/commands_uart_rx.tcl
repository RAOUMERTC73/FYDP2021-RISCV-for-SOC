.main clear;
vlog uart_rx.sv uart_rx_tb.sv;
vsim work.uart_rx_tb;
add wave -position insertpoint sim:/uart_rx_tb/*;
add wave -position insertpoint sim:/uart_rx_tb/uart_rx_DUT/*;
run -a;
wave zoom full;