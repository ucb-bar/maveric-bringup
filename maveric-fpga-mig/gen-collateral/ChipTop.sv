// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

module ChipTop(
  output        port_clock,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
                port_bits_in_ready,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  input         port_bits_in_valid,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  input  [3:0]  port_bits_in_bits,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  input         port_bits_out_ready,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  output        port_bits_out_valid,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  output [3:0]  port_bits_out_bits,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:350:20]
  input         tl_slave_0_a_ready,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output        tl_slave_0_a_valid,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output [2:0]  tl_slave_0_a_bits_opcode,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
                tl_slave_0_a_bits_param,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
                tl_slave_0_a_bits_size,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output [3:0]  tl_slave_0_a_bits_source,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output [31:0] tl_slave_0_a_bits_address,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output [7:0]  tl_slave_0_a_bits_mask,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output [63:0] tl_slave_0_a_bits_data,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  output        tl_slave_0_a_bits_corrupt,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
                tl_slave_0_d_ready,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input         tl_slave_0_d_valid,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input  [2:0]  tl_slave_0_d_bits_opcode,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input  [1:0]  tl_slave_0_d_bits_param,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input  [2:0]  tl_slave_0_d_bits_size,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input  [3:0]  tl_slave_0_d_bits_source,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input         tl_slave_0_d_bits_sink,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
                tl_slave_0_d_bits_denied,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input  [63:0] tl_slave_0_d_bits_data,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
  input         tl_slave_0_d_bits_corrupt,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:492:33]
                reset_io,	// @[generators/chipyard/src/main/scala/clocking/ClockBinders.scala:105:24]
                clock_uncore,	// @[generators/chipyard/src/main/scala/clocking/ClockBinders.scala:113:26]
                clock_serial_tl_clock_0,	// @[generators/chipyard/src/main/scala/clocking/ClockBinders.scala:113:26]
  output        uart_tsi_uart_txd,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:484:22]
  input         uart_tsi_uart_rxd,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:484:22]
  output        uart_tsi_dropped,	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:484:22]
  output [3:0]  uart_tsi_tsi2tl_state	// @[generators/chipyard/src/main/scala/iobinders/IOBinders.scala:484:22]
);

  DigitalTop system (	// @[generators/chipyard/src/main/scala/ChipTop.scala:28:35]
    .auto_prci_ctrl_domain_resetSynchronizer_in_member_allClocks_serial_tl_clock_0_clock (clock_serial_tl_clock_0),
    .auto_prci_ctrl_domain_resetSynchronizer_in_member_allClocks_serial_tl_clock_0_reset (reset_io),
    .auto_prci_ctrl_domain_resetSynchronizer_in_member_allClocks_uncore_clock            (clock_uncore),
    .auto_prci_ctrl_domain_resetSynchronizer_in_member_allClocks_uncore_reset            (reset_io),
    .mem_tl_0_a_ready                                                                    (tl_slave_0_a_ready),
    .mem_tl_0_a_valid                                                                    (tl_slave_0_a_valid),
    .mem_tl_0_a_bits_opcode                                                              (tl_slave_0_a_bits_opcode),
    .mem_tl_0_a_bits_param                                                               (tl_slave_0_a_bits_param),
    .mem_tl_0_a_bits_size                                                                (tl_slave_0_a_bits_size),
    .mem_tl_0_a_bits_source                                                              (tl_slave_0_a_bits_source),
    .mem_tl_0_a_bits_address                                                             (tl_slave_0_a_bits_address),
    .mem_tl_0_a_bits_mask                                                                (tl_slave_0_a_bits_mask),
    .mem_tl_0_a_bits_data                                                                (tl_slave_0_a_bits_data),
    .mem_tl_0_a_bits_corrupt                                                             (tl_slave_0_a_bits_corrupt),
    .mem_tl_0_d_ready                                                                    (tl_slave_0_d_ready),
    .mem_tl_0_d_valid                                                                    (tl_slave_0_d_valid),
    .mem_tl_0_d_bits_opcode                                                              (tl_slave_0_d_bits_opcode),
    .mem_tl_0_d_bits_param                                                               (tl_slave_0_d_bits_param),
    .mem_tl_0_d_bits_size                                                                (tl_slave_0_d_bits_size),
    .mem_tl_0_d_bits_source                                                              (tl_slave_0_d_bits_source),
    .mem_tl_0_d_bits_sink                                                                (tl_slave_0_d_bits_sink),
    .mem_tl_0_d_bits_denied                                                              (tl_slave_0_d_bits_denied),
    .mem_tl_0_d_bits_data                                                                (tl_slave_0_d_bits_data),
    .mem_tl_0_d_bits_corrupt                                                             (tl_slave_0_d_bits_corrupt),
    .uart_tsi_io_uart_txd                                                                (uart_tsi_uart_txd),
    .uart_tsi_io_uart_rxd                                                                (uart_tsi_uart_rxd),
    .uart_tsi_io_dropped                                                                 (uart_tsi_dropped),
    .uart_tsi_io_tsi2tl_state                                                            (uart_tsi_tsi2tl_state),
    .serial_tl_clock                                                                     (port_clock),
    .serial_tl_bits_in_ready                                                             (port_bits_in_ready),
    .serial_tl_bits_in_valid                                                             (port_bits_in_valid),
    .serial_tl_bits_in_bits                                                              (port_bits_in_bits),
    .serial_tl_bits_out_ready                                                            (port_bits_out_ready),
    .serial_tl_bits_out_valid                                                            (port_bits_out_valid),
    .serial_tl_bits_out_bits                                                             (port_bits_out_bits)
  );
endmodule
