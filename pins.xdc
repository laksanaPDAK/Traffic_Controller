############################################################
## Basys 3 Constraint File
## FPGA  : XC7A35T-1CPG236C
## Clock : 100 MHz
############################################################

############################
## CLOCK INPUT
############################
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name sys_clk -period 10.000 [get_ports clk]

############################
## PUSH BUTTON INPUTS
############################

## Reset button (btnC)
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Pedestrian button (btnU)
set_property PACKAGE_PIN T18 [get_ports ped_btn]
set_property IOSTANDARD LVCMOS33 [get_ports ped_btn]

## Emergency button (btnL)
set_property PACKAGE_PIN W19 [get_ports emer_btn]
set_property IOSTANDARD LVCMOS33 [get_ports emer_btn]

############################
## LED OUTPUTS
############################

## Car traffic LEDs
set_property PACKAGE_PIN U16 [get_ports car_red]      ;# LD0
set_property PACKAGE_PIN E19 [get_ports car_yellow]   ;# LD1
set_property PACKAGE_PIN U19 [get_ports car_green]    ;# LD2

## Pedestrian LEDs
set_property PACKAGE_PIN V19 [get_ports ped_red]      ;# LD3
set_property PACKAGE_PIN W18 [get_ports ped_green]    ;# LD4

set_property IOSTANDARD LVCMOS33 [get_ports {car_red car_yellow car_green ped_red ped_green}]

############################
## SEVEN-SEGMENT DISPLAY
## Common Anode, Active LOW
############################

## Segment pins (a b c d e f g)
set_property PACKAGE_PIN W7 [get_ports seg[0]]   ;# a
set_property PACKAGE_PIN W6 [get_ports seg[1]]   ;# b
set_property PACKAGE_PIN U8 [get_ports seg[2]]   ;# c
set_property PACKAGE_PIN V8 [get_ports seg[3]]   ;# d
set_property PACKAGE_PIN U5 [get_ports seg[4]]   ;# e
set_property PACKAGE_PIN V5 [get_ports seg[5]]   ;# f
set_property PACKAGE_PIN U7 [get_ports seg[6]]   ;# g

## Digit enable (anodes)
set_property PACKAGE_PIN U2 [get_ports an[0]]    ;# rightmost digit
set_property PACKAGE_PIN U4 [get_ports an[1]]
set_property PACKAGE_PIN V4 [get_ports an[2]]
set_property PACKAGE_PIN W4 [get_ports an[3]]    ;# leftmost digit

## Correct wildcard usage
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*] an[*]}]

############################################################
## END OF CONSTRAINT FILE
############################################################