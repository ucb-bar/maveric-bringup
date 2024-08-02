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

module UARTToSerial(
  input        clock,
               reset,
  output       io_uart_txd,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  input        io_uart_rxd,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  output       io_serial_in_ready,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  input        io_serial_in_valid,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  input  [7:0] io_serial_in_bits,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  input        io_serial_out_ready,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  output       io_serial_out_valid,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  output [7:0] io_serial_out_bits,	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
  output       io_dropped	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:108:14]
);

  wire       _txq_io_deq_valid;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:117:19]
  wire [7:0] _txq_io_deq_bits;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:117:19]
  wire       _txm_io_in_ready;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:116:19]
  wire       _rxq_io_enq_ready;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:115:19]
  wire       _rxm_io_out_valid;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19]
  wire [7:0] _rxm_io_out_bits;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19]
  reg        dropped;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:121:24]
  `ifndef SYNTHESIS	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
    always @(posedge clock) begin	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
      if (_rxm_io_out_valid & ~reset & ~_rxq_io_enq_ready) begin	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19, :115:19, :128:35]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
          $error("Assertion failed\n    at UARTAdapter.scala:128 when (rxq.io.enq.valid) { assert(rxq.io.enq.ready) }\n");	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
        if (`STOP_COND_)	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
          $fatal;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:128:35]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (reset)
      dropped <= 1'h0;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:121:24]
    else
      dropped <= _rxm_io_out_valid & ~_rxq_io_enq_ready | dropped;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19, :115:19, :121:24, :128:35, :129:{26,48,58}]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        dropped = _RANDOM[/*Zero width*/ 1'b0][0];	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:121:24]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  UARTRx rxm (	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19]
    .clock        (clock),
    .reset        (reset),
    .io_en        (1'h1),
    .io_in        (io_uart_rxd),
    .io_out_valid (_rxm_io_out_valid),
    .io_out_bits  (_rxm_io_out_bits),
    .io_div       (16'hD9)	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:125:14]
  );
  Queue_58 rxq (	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:115:19]
    .clock        (clock),
    .reset        (reset),
    .io_enq_ready (_rxq_io_enq_ready),
    .io_enq_valid (_rxm_io_out_valid),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19]
    .io_enq_bits  (_rxm_io_out_bits),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:114:19]
    .io_deq_ready (io_serial_out_ready),
    .io_deq_valid (io_serial_out_valid),
    .io_deq_bits  (io_serial_out_bits)
  );
  UARTTx txm (	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:116:19]
    .clock       (clock),
    .reset       (reset),
    .io_en       (1'h1),
    .io_in_ready (_txm_io_in_ready),
    .io_in_valid (_txq_io_deq_valid),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:117:19]
    .io_in_bits  (_txq_io_deq_bits),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:117:19]
    .io_out      (io_uart_txd),
    .io_div      (16'hD9),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:125:14]
    .io_nstop    (1'h0),
    .io_tx_busy  (/* unused */)
  );
  Queue_58 txq (	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:117:19]
    .clock        (clock),
    .reset        (reset),
    .io_enq_ready (io_serial_in_ready),
    .io_enq_valid (io_serial_in_valid),
    .io_enq_bits  (io_serial_in_bits),
    .io_deq_ready (_txm_io_in_ready),	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:116:19]
    .io_deq_valid (_txq_io_deq_valid),
    .io_deq_bits  (_txq_io_deq_bits)
  );
  assign io_dropped = dropped;	// @[generators/testchipip/src/main/scala/UARTAdapter.scala:121:24]
endmodule
