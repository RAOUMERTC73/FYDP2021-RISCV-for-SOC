.main clear;
restart -f;
vlog Single_Cycle_Top.v Single_Cycle_Top_Tb.v;
vsim Single_Cycle_Top_Tb;
add wave -position insertpoint sim:/Single_Cycle_Top_Tb/*;
run -a;
wave zoom full;
