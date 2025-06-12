onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group testbench /i2c_testbench/clk
add wave -noupdate -expand -group testbench /i2c_testbench/rst
add wave -noupdate -expand -group testbench /i2c_testbench/addr
add wave -noupdate -expand -group testbench /i2c_testbench/data_in
add wave -noupdate -expand -group testbench /i2c_testbench/enable
add wave -noupdate -expand -group testbench /i2c_testbench/rw
add wave -noupdate -expand -group testbench /i2c_testbench/read_data
add wave -noupdate -expand -group testbench /i2c_testbench/recived_addr
add wave -noupdate -expand -group testbench /i2c_testbench/write_data
add wave -noupdate -expand -group testbench /i2c_testbench/ready
add wave -noupdate -expand -group testbench /i2c_testbench/state
add wave -noupdate -expand -group testbench /i2c_testbench/i2c_clk
add wave -noupdate -expand -group testbench /i2c_testbench/i2c_sda
add wave -noupdate -expand -group testbench /i2c_testbench/i2c_scl
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/clk
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/rst
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/addr
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/data_in
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/enable
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/rw
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/read_data
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/ready
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/state
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/i2c_clk
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/i2c_sda
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/i2c_scl
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/saved_addr
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/saved_data
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/counter
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/counter2
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/write_enable
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/sda_out
add wave -noupdate -expand -group i2c_master /i2c_testbench/master/i2c_scl_enable
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/recived_addr
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/write_data
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/sda
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/scl
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/addr
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/counter
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/state
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/data_in
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/data_out
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/sda_out
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/sda_in
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/start
add wave -noupdate -expand -group i2c_slave /i2c_testbench/slave/write_enable
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
WaveRestoreZoom {0 ps} {10 ns}
