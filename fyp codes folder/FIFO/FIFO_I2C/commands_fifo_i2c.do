# Clear the transcript
.main clear;

# Compile the design and testbench
vlog fifo_i2c.sv;
vlog fifo_i2c_tb.sv;

# Simulate the testbench
vsim fifo_i2c_tb;

# Add wave window and append all signals
add wave -position insertpoint sim:/fifo_i2c_tb/*;
add wave -position insertpoint sim:/fifo_i2c_tb/DUT/*;

# Run the simulation
run -all;
wave zoom full;
radix hex;