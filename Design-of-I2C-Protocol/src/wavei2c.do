onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/read_data
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/recived_addr
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/write_data
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/ready
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/state
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/i2c_clk
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/i2c_sda
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/i2c_scl
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/clk
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/rst
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/addr
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/data_in
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/enable
add wave -noupdate -expand -group i2c_waveformate /i2c_testbench/rw
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
