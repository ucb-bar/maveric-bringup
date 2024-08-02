set_property PACKAGE_PIN {R4} [get_ports {sys_clock}]
set_property IOSTANDARD {LVCMOS33} [get_ports {sys_clock}]
set_property PACKAGE_PIN {V18} [get_ports {uart_rxd}]
set_property IOSTANDARD {LVCMOS33} [get_ports {uart_rxd}]
set_property IOB {TRUE} [ get_cells -of_objects [ all_fanin -flat -startpoints_only [get_ports {uart_rxd}]]]
set_property PACKAGE_PIN {AA19} [get_ports {uart_txd}]
set_property IOSTANDARD {LVCMOS33} [get_ports {uart_txd}]
set_property IOB {TRUE} [ get_cells -of_objects [ all_fanin -flat -startpoints_only [get_ports {uart_txd}]]]
set_property PACKAGE_PIN {T14} [get_ports {led_0}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_0}]
set_property PACKAGE_PIN {T15} [get_ports {led_1}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_1}]
set_property PACKAGE_PIN {T16} [get_ports {led_2}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_2}]
set_property PACKAGE_PIN {U16} [get_ports {led_3}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_3}]
set_property PACKAGE_PIN {V15} [get_ports {led_4}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_4}]
set_property PACKAGE_PIN {W16} [get_ports {led_5}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_5}]
set_property PACKAGE_PIN {W15} [get_ports {led_6}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_6}]
set_property PACKAGE_PIN {Y13} [get_ports {led_7}]
set_property IOSTANDARD {LVCMOS33} [get_ports {led_7}]
set_property BOARD_PIN {reset} [get_ports {reset}]
# make it button?
#set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { reset }];
#set_property PACKAGE_PIN {AB22} [get_ports {serial_tl_clock}]
#set_property IOSTANDARD {LVCMOS33} [get_ports {serial_tl_clock}]
#set_property CLOCK_DEDICATED_ROUTE {FALSE} [get_nets [get_ports {serial_tl_clock}]]
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_clock }]; #IO_L13P_T2_MRCC_15 Sch=fmc_la00_cc_p
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_valid }]; #IO_L17N_T2_A25_15 Sch=fmc_la_n[03]
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_ready }]; #IO_L17P_T2_A26_15 Sch=fmc_la_p[03]
set_property -dict { PACKAGE_PIN L21   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_valid }]; #IO_L10N_T1_AD11N_15 Sch=fmc_la_n[05]
set_property -dict { PACKAGE_PIN M21   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_ready }]; #IO_L10P_T1_AD11P_15 Sch=fmc_la_p[05]
set_property -dict { PACKAGE_PIN M22   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_bits[1] }]; #IO_L15N_T2_DQS_ADV_B_15 Sch=fmc_la_n[06]
set_property -dict { PACKAGE_PIN N22   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_bits[0] }]; #IO_L15P_T2_DQS_15 Sch=fmc_la_p[06]
set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_bits[1] }]; #IO_L8N_T1_AD10N_15 Sch=fmc_la_n[09]
set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_bits[0] }]; #IO_L8P_T1_AD10P_15 Sch=fmc_la_p[09]
set_property -dict { PACKAGE_PIN K22   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_bits[3] }]; #IO_L9N_T1_DQS_AD3N_15 Sch=fmc_la_n[10]
set_property -dict { PACKAGE_PIN K21   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_out_bits[2] }]; #IO_L9P_T1_DQS_AD3P_15 Sch=fmc_la_p[10]
set_property -dict { PACKAGE_PIN H22   IOSTANDARD LVCMOS12 } [get_ports { fpga_gpio[1] }]; #IO_L7N_T1_AD2N_15 Sch=fmc_la_n[14]
set_property -dict { PACKAGE_PIN J22   IOSTANDARD LVCMOS12 } [get_ports { fpga_gpio[0] }]; #IO_L7P_T1_AD2P_15 Sch=fmc_la_p[14]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_bits[3] }]; #IO_L23N_T3_FWE_B_15 Sch=fmc_la_n[15]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS12 } [get_ports { serial_tl_bits_in_bits[2] }]; #IO_L23P_T3_FOE_B_15 Sch=fmc_la_p[15]
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS12 } [get_ports { fpga_gpio[3] }]; #IO_L16N_T2_16 Sch=fmc_la_n[27]
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS12 } [get_ports { fpga_gpio[2] }]; #IO_L16P_T2_16 Sch=fmc_la_p[27]
