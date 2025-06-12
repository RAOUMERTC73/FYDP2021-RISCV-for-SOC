.main clear;

vlog ../i2c_master/i2c_master.sv;
vlog ../i2c_slave/i2c_slave.sv;
vlog i2c_top.sv;
vlog i2c_top_tb.sv;

vsim work.i2c_top_tb;
add wave -position insertpoint sim:/i2c_top_tb/*;
add wave -position insertpoint sim:/i2c_top_tb/dut/*;

run -a;
wave zoom full;