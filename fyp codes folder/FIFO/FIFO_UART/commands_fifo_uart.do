# Clear the transcript
.main clear;

# Compile the design and testbench
vlog fifo_uart.sv;
vlog fifo_uart_tb.sv;

# Simulate the testbench
vsim fifo_uart_tb;

# Add wave window and append all signals
add wave -position insertpoint sim:/fifo_uart_tb/*;
add wave -position insertpoint sim:/fifo_uart_tb/DUT/*;

# Run the simulation
run -all;
wave zoom full;