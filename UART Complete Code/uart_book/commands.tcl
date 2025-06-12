# .main clear;
# # vlib work;
# vlog uart_top.sv uart_tx.sv uart_rx.sv fifo.sv mod_m_counter.sv uart_tb.sv;
# vsim uart_tb;
# add wave -position insertpoint sim:/uart_tb/*
# # add wave -position insertpoint sim:/uart_tx_tb/uut/*
# run -a;
# wave zoom full;

# .main clear;
# # vlib work;
# vlog  uart_tx.sv uart_tx_tb.sv;
# vsim uart_tx_tb;
# add wave -position insertpoint sim:/uart_tx_tb/*
# # add wave -position insertpoint sim:/uart_tx_tb/uut/*
# run -a;
# wave zoom full;

.main clear;
# vlib work;
vlog  uart_rx.sv uart_rx_tb.sv;
vsim uart_rx_tb;
add wave -position insertpoint sim:/uart_rx_tb/*
# add wave -position insertpoint sim:/uart_tx_tb/uut/*
run -a;
wave zoom full;

# .main clear;
# vlog  uart_rx.sv uart_rx_tb.sv uart_tx.sv uart_tx_tb.sv;
# vsim uart_tx_tb uart_rx_tb;
