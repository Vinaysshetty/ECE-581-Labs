create_clock -name "CLK" -period 0.500 -waveform {0.0 0.250} clock

set_clock_transition 0.100 CLK

set_input_delay 0.25 [ get_ports {a b cin } ] -clock [ get_clock CLK ]
set_output_delay 0.25 [get_ports {sum cout} ] -clock [ get_clock  CLK ]

