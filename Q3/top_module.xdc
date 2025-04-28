## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports sys_clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports sys_clk]


##Switches

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports sw]

##7 segment display

set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports CA]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports CB]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports CC]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports CD]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports CE]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports CF]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports CG]

set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports DP]

set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {AN[0]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {AN[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {AN[2]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {AN[3]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {AN[4]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {AN[5]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {AN[6]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {AN[7]}]


##Buttons

set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports sum_button_n]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports clr_button_n]

##Pmod Header JA

set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports D]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports C]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports B]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports A]

##Pmod Header JB

set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports G]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports F]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports E]
