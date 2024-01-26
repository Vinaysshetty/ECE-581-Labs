
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

#clock definitions 

set wclk_period 1.380 

set rclk_period 1.255 

set wclk2x_period [ expr $wclk_period / 2 ] 

  

create_clock -name "wclk" -period $wclk_period  wclk 

  

create_clock -name "rclk" -period $rclk_period rclk 

  

#Add the new clock.  Make it 1/2 the wclk period since it is called wclk2x 

create_clock -name "wclk2x" -period $wclk2x_period wclk2x 

  

#exceptions 

set_false_path -from [get_clocks wclk ] -to [get_clocks rclk] 

set_false_path -from [get_clocks rclk ] -to [ get_clocks wclk] 

  

#clock definition modifications 

set_clock_transition 0.1 [get_clocks] 

set_clock_transition 0.25 [get_clocks rclk] 

set_clock_transition 0.25 [get_clocks wclk] 

set_clock_latency 0.33 [get_clocks] 

set_clock_uncertainty 0.048 [get_clocks] 

set_clock_uncertainty 0.053 [get_clocks wclk] 

# set_IO_constraints 

#input delay 

set_input_delay 0.00001 -max -clock wclk -add_delay [get_ports wdata*] 

set_input_delay 0.00001 -min -clock wclk -add_delay [get_ports wdata*] 

set_input_delay 0.00001 -max -clock wclk -add_delay [get_ports winc] 

set_input_delay 0.00001 -min -clock wclk -add_delay [get_ports winc] 

set_input_delay 0.00001 -max -clock rclk -add_delay [get_ports rinc] 

set_input_delay 0.00001 -min -clock rclk -add_delay [get_ports rinc] 

#output delay 

set_output_delay -0.45 -max -clock rclk -add_delay [get_ports rdata*] 

set_output_delay -0.45 -min -clock rclk -add_delay [get_ports rdata*] 

set_output_delay -0.45 -max -clock rclk -add_delay [get_ports rempty] 

set_output_delay -0.45 -min -clock rclk -add_delay [get_ports rempty] 

set_output_delay -0.45 -max -clock wclk -add_delay [get_ports wfull] 

set_output_delay -0.45 -min -clock wclk -add_delay [get_ports wfull] 

#input drive 

set_drive 0.000001 [get_ports wdata*] 

set_drive 0.000001 [get_ports winc] 

set_drive 0.000001 [get_ports rinc] 

#output load 

set_load 0.8 [get_ports rdata*] 

set_load 0.8 [get_ports rempty] 

set_load 0.8 [get_ports wfull] 

  

#group_path -name INTERNAL -from [all_clocks] -to [all_clocks ] 

group_path -name INPUTS -from [ get_ports -filter "direction==in&&full_name!~*clk*" ] 

group_path -name OUTPUTS -to [ get_ports -filter "direction==out" ] 
