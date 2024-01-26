set startp_col [get_pins -of_obj [ get_cells -hier -filter "ref_name=~*DFF*" ] -filter "full_name=~*/CLK" ]
set endp_col [get_pins -of_obj [ get_cells -hier -filter "ref_name=~*DFF*" ] -filter "full_name=~*/D" ]
set timing_paths [get_timing_path -from $startp_col -to $endp_col -max_path 1000 ]
puts [ format "%8s %8s %8s %30s %30s" "Slack" "S_Slack" "E_Slack" "Startp" "Endp"]
foreach_in_collection i [sort_collection $timing_paths slack] {
   set this_start [ get_attribute $i startpoint ]
   set this_start_name [ get_attribute $this_start full_name ]
   set this_start_cell [ get_cell -of_obj $this_start ]
   set this_start_cell_d [ get_pin -of_obj $this_start_cell -filter "full_name=~*/D" ]
   set this_end [ get_attribute $i endpoint ]
   set this_end_name [ get_attribute $this_end full_name ]
   set this_end_cell [ get_cell -of_obj $this_end ]
   set this_end_cell_q [ get_pins -of_obj $this_end_cell -filter "full_name=~*/Q*" ]
   set this_slack [ get_attribute $i slack ]
   set this_slack_worst [ lindex [ lsort -real $this_slack ] 0 ]
   set this_start_slack [ get_attribute -quiet $this_start_cell_d worst_slack ]
   set this_start_slack_worst [ lindex [ lsort -real $this_start_slack ] 0 ]
   if { $this_start_slack_worst == "" } { set this_start_slack_worst 9.999 }
   set this_end_slack [ get_attribute -quiet $this_end_cell_q worst_slack ]
   set this_end_slack_worst [ lindex [ lsort -real $this_end_slack ] 0 ]
   if { $this_end_slack_worst == "" } { set this_end_slack_worst 9.999 }
   puts [ format "%8.3f %8.3f %8.3f %30s %30s" $this_slack_worst $this_start_slack_worst $this_end_slack_worst $this_start_name $this_end_name ]
}
