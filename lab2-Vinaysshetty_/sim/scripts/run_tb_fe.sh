
# Make sure to exprt top=simple_adder
# source ../scripts/run_tb_fe.sh

/pkgs/mentor/questa/10.6b/questasim/bin/vlib work
/pkgs/mentor/questa/10.6b/questasim/bin/vmap work
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../../syn/rtl/${TOP}.sv
/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../rtl/${TOP}_tb.v
/pkgs/mentor/questa/10.6b/questasim/bin/vsim -debugDB top -do  "add wave sim:/top/* ; run -all"

#/pkgs/mentor/questa/10.6b/questasim/bin/vsim -debugDB top -f ../scripts/tb_fe.vsim
#restart -f
#add wave sim:/top/*
#run -all

#/pkgs/mentor/questa/10.6b/questasim/bin/vlog ../../syn/outputs/simple_adder.dc.vg
#/pkgs/mentor/questa/10.6b/questasim/bin/vlog /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib/stdcell_rvt/verilog/saed32nm.v
#restart -f
#add wave sim:/top/*
#run -all
