onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/clk
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/rst
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/newd
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/addr
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/op
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/sda
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/scl
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/din
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/dout
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/busy
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/ack_err
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/done
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/scl_t
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/sda_t
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/count1
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/i2c_clk
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/pulse
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/bitcount
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/data_addr
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/data_tx
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/r_ack
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/r_scl
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/rx_data
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/sda_en
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/scl_en
add wave -noupdate -expand -group i2c_master /i2c_top_tb/dut/master/state
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/clk
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/rst
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/stretch
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/sda
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/scl
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/ack_err
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/done
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/state
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/r_addr
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/addr
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/r_mem
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/w_mem
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/dout
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/din
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/sda_t
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/sda_en
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/bitcnt
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/scl_en
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/scl_t
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/count1
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/i2c_clk
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/pulse
add wave -noupdate -expand -group i2c_Slave /i2c_top_tb/dut/slave/r_ack
add wave -noupdate -expand -group i2c_top /i2c_top_tb/clk
add wave -noupdate -expand -group i2c_top /i2c_top_tb/rst
add wave -noupdate -expand -group i2c_top /i2c_top_tb/newd
add wave -noupdate -expand -group i2c_top /i2c_top_tb/op
add wave -noupdate -expand -group i2c_top /i2c_top_tb/stretch
add wave -noupdate -expand -group i2c_top /i2c_top_tb/addr
add wave -noupdate -expand -group i2c_top /i2c_top_tb/din
add wave -noupdate -expand -group i2c_top /i2c_top_tb/dout
add wave -noupdate -expand -group i2c_top /i2c_top_tb/busy
add wave -noupdate -expand -group i2c_top /i2c_top_tb/ack_err
add wave -noupdate -expand -group i2c_top /i2c_top_tb/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161 ps} 0}
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
WaveRestoreZoom {0 ps} {184847 ps}
