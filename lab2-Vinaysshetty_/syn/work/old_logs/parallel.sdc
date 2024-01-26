if { [info exists synopsys_program_name ] && ($synopsys_program_name == "icc2_shell") } {
    puts " Creating ICC2 MCMM "
    create_mode func
    create_corner slow
    create_scenario -mode func -corner slow -name func_slow
    current_scenario func_slow
    set_operating_conditions ss0p75v125c
    read_parasitic_tech -tlup $tlu_dir/saed32nm_1p9m_Cmax.tluplus -layermap $tlu_dir/saed32nm_tf_itf_tluplus.map -name Cmax
    read_parasitic_tech -tlup $tlu_dir/saed32nm_1p9m_Cmin.tluplus -layermap $tlu_dir/saed32nm_tf_itf_tluplus.map -name Cmin
    set_parasitic_parameters -early_spec Cmax -early_temperature 125
    set_parasitic_parameters -late_spec Cmax -late_temperature 125
    #set_parasitic_parameters -early_spec 1p9m_Cmax -early_temperature 125 -corner default
    #set_parasitic_parameters -late_spec 1p9m_Cmax -late_temperature 125 -corner default

    #set_scenario_status  default -active false
    set_scenario_status func_slow -active true -hold true -setup true
}
set wclk_period 1.5
set rclk_period 1.5
set wclk2x_period [ expr $wclk_period / 2 ]

create_clock -name "wclk" -period $wclk_period  wclk

create_clock -name "rclk" -period $rclk_period rclk

#Add the new clock.  Make it 1/2 the wclk period since it is called wclk2x
create_clock -name "wclk2x" -period $wclk2x_period wclk2x

set_false_path -from [get_clocks wclk ] -to [get_clocks rclk]
set_false_path -from [get_clocks rclk ] -to [ get_clocks wclk]

# Add input/output delays in relation to related clocks
# Can tell the related clock by doing report_timing -group INPUTS  or -group OUTPUTS after using group_path
# External delay should be some percentage of clock period.
# Tune/relax if violating; most concerned about internal paths.

# I like set_driving_cell to a std cell from the library.  set_drive works to.
#set_clock_transition 0.2{rclk wclk wclk2x}
#set_clock_latency 0.1 {rclk wclk wclk2x}
#set_clock_uncertainty 0.4 {rclk wclk wclk2x}
set_clock_transition 0.2 [get_clocks]
set_clock_uncertainty 0.4 [get_clocks]
set_clock_latency 0.1 [get_clocks]
# set_load
set_input_delay 0.2 -max -clock wclk -add_delay [get_ports wdata*]
set_input_delay 0.2 -min -clock wclk -add_delay [get_ports wdata*]
set_input_delay 0.2 -max -clock wclk -add_delay [get_ports winc]
set_input_delay 0.2 -min -clock wclk -add_delay [get_ports winc]

set_input_delay 0.2 -max -clock rclk -add_delay [get_ports rinc]
set_input_delay 0.2 -min -clock rclk -add_delay [get_ports rinc]

set_output_delay 0.8 -max -clock rclk -add_delay [get_ports rdata*]
set_output_delay 0.8 -min -clock rclk -add_delay [get_ports rdata*]
set_output_delay 0.8 -max -clock rclk -add_delay [get_ports rempty]
set_output_delay 0.8 -min -clock rclk -add_delay [get_ports rempty]

set_output_delay 0.8 -max -clock wclk -add_delay [get_ports wfull]
set_output_delay 0.8 -min -clock wclk -add_delay [get_ports wfull]

set_drive 0.02 [get_ports wdata*]
set_drive 0.02 [get_ports winc]
set_drive 0.02 [get_ports rinc]

set_load 0.1 [get_ports rdata*]
set_load 0.1 [get_ports rempty]
set_load 0.1 [get_ports wfull]



#set_max_area 0.0

#set_input_delay 0.00001 -max -clock rclk -add_delay {winc}
#set_input_delay 0.00001 -max -clock wclk -add_delay {winc}
#set_input_delay 0.00001 -max -clock rclk -add_delay [all_inputs]
#set_input_delay 0.00001 -max -clock wclk -add_delay [all_inputs]
#set_input_delay 0.00001 -min -clock rclk -add_delay [all_inputs]
#set_input_delay 0.00001 -min -clock wclk -add_delay [all_inputs]
#set_output_delay 0.00001 -min -clock wclk -add_delay [all_outputs]
#set_output_delay 0.00001 -min -clock rclk -add_delay [all_outputs]
#set_output_delay 0.00001 -max -clock wclk -add_delay [all_outputs]
#set_output_delay 0.00001 -max -clock rclk -add_delay [all_outputs]
#set_drive 0.00001 [all_inputs]
#set_load 0.000001 [all_outputs]

#group_path -name INTERNAL -from [all_clocks] -to [all_clocks ]
group_path -name INPUTS -from [ get_ports -filter "direction==in&&full_name!~*clk*" ]
group_path -name OUTPUTS -to [ get_ports -filter "direction==out" ]

