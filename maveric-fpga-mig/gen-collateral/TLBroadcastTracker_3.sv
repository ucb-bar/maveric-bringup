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

module TLBroadcastTracker_3(
  input         clock,
                reset,
                io_in_a_first,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output        io_in_a_ready,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input         io_in_a_valid,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input  [2:0]  io_in_a_bits_opcode,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_in_a_bits_param,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_in_a_bits_size,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input  [4:0]  io_in_a_bits_source,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input  [31:0] io_in_a_bits_address,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input  [7:0]  io_in_a_bits_mask,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input  [63:0] io_in_a_bits_data,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input         io_out_a_ready,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output        io_out_a_valid,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [2:0]  io_out_a_bits_opcode,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_out_a_bits_param,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_out_a_bits_size,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [6:0]  io_out_a_bits_source,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [31:0] io_out_a_bits_address,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [7:0]  io_out_a_bits_mask,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [63:0] io_out_a_bits_data,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  input         io_probedack,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_d_last,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [4:0]  io_source,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output [25:0] io_line,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
  output        io_idle,	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
                io_need_d	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:401:14]
);

  wire        _io_in_a_ready_output;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:486:45]
  wire        _o_data_q_io_enq_ready;	// @[src/main/scala/chisel3/util/Decoupled.scala:376:21]
  reg         got_e;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24]
  reg         sent_d;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:425:24]
  reg  [2:0]  opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:427:20]
  reg  [2:0]  param;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:428:20]
  reg  [2:0]  size;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:429:20]
  reg  [4:0]  source;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:430:20]
  reg  [31:0] address;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:433:24]
  wire        idle = got_e & sent_d;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :425:24, :436:23]
  wire        _GEN = _io_in_a_ready_output & io_in_a_valid & io_in_a_first;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:438:22, :486:45]
  `ifndef SYNTHESIS	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
    always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
      if (_GEN & ~reset & ~idle) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:436:23, :438:22, :439:12]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
          $error("Assertion failed\n    at Broadcast.scala:439 assert (idle)\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12]
      end
      if (io_d_last & ~reset & sent_d) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:425:24, :439:12, :460:12]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:460:12]
          $error("Assertion failed\n    at Broadcast.scala:460 assert (!sent_d)\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:460:12]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:460:12]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:460:12]
      end
      if (io_probedack & ~reset) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:439:12, :469:12]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:469:12]
          $error("Assertion failed\n    at Broadcast.scala:469 assert (count > 0.U)\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:469:12]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:469:12]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:469:12]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign _io_in_a_ready_output = (idle | ~io_in_a_first) & _o_data_q_io_enq_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:436:23, :486:{26,29,45}, src/main/scala/chisel3/util/Decoupled.scala:376:21]
  wire        acquire = opcode == 3'h6 | (&opcode);	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:427:20, :442:36, :492:{24,52,62}]
  always @(posedge clock) begin
    if (reset) begin
      got_e <= 1'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24]
      sent_d <= 1'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:425:24]
      address <= 32'hC0;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:433:24]
    end
    else begin
      if (_GEN) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:438:22]
        got_e <= io_in_a_bits_opcode != 3'h6 & io_in_a_bits_opcode != 3'h7;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :442:{36,64,87}]
        address <= io_in_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:433:24]
      end
      sent_d <= io_d_last | ~_GEN & sent_d;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:425:24, :438:{22,40}, :440:13, :459:20, :461:12]
    end
    if (_GEN) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:438:22]
      opcode <= io_in_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:427:20]
      param <= io_in_a_bits_param;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:428:20]
      size <= io_in_a_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:429:20]
      source <= io_in_a_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:430:20]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:1];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        got_e = _RANDOM[1'h0][0];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24]
        sent_d = _RANDOM[1'h0][1];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :425:24]
        opcode = _RANDOM[1'h0][5:3];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :427:20]
        param = _RANDOM[1'h0][8:6];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :428:20]
        size = _RANDOM[1'h0][11:9];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :429:20]
        source = _RANDOM[1'h0][16:12];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :430:20]
        address = {_RANDOM[1'h0][31:17], _RANDOM[1'h1][16:0]};	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:424:24, :433:24]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Queue_62 o_data_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:376:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (_o_data_q_io_enq_ready),
    .io_enq_valid     ((idle | ~io_in_a_first) & io_in_a_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:436:23, :486:29, :487:{25,44}]
    .io_enq_bits_mask (io_in_a_bits_mask),
    .io_enq_bits_data (io_in_a_bits_data),
    .io_deq_ready     (io_out_a_ready),
    .io_deq_valid     (io_out_a_valid),
    .io_deq_bits_mask (io_out_a_bits_mask),
    .io_deq_bits_data (io_out_a_bits_data)
  );
  assign io_in_a_ready = _io_in_a_ready_output;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:486:45]
  assign io_out_a_bits_opcode = acquire ? 3'h4 : opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:427:20, :492:52, :498:31]
  assign io_out_a_bits_param = acquire ? 3'h0 : param;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:428:20, :492:52, :499:31]
  assign io_out_a_bits_size = size;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:429:20]
  assign io_out_a_bits_source = {{2{acquire}}, source};	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:430:20, :492:52, :501:{31,35}]
  assign io_out_a_bits_address = address;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:433:24]
  assign io_source = source;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:430:20]
  assign io_line = address[31:6];	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:433:24, :480:22]
  assign io_idle = idle;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:436:23]
  assign io_need_d = ~sent_d;	// @[generators/rocket-chip/src/main/scala/tilelink/Broadcast.scala:425:24, :478:16]
endmodule
