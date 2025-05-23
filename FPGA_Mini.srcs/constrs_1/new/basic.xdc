set_property PACKAGE_PIN A10 [get_ports clk]   
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 [get_ports clk]
