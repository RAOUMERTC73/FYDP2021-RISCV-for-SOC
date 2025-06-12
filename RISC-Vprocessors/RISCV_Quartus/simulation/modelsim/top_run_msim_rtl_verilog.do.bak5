transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/top.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/adder.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/alu.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/aludec.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/controller.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/datapath.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/dmem.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/extend.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/flopr.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/imem.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/maindec.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/mux2.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/mux3.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/regfile.sv}
vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/riscvsingle.sv}

vlog -sv -work work +incdir+C:/Users/Rao/Desktop/RISC-V\ Single\ Cycle\ Core\ in\ Verilog/RISC-Vprocessors/RISCV_Quartus {C:/Users/Rao/Desktop/RISC-V Single Cycle Core in Verilog/RISC-Vprocessors/RISCV_Quartus/top_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
