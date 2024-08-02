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

module HellaPeekingArbiter(
  input         clock,
                reset,
  output        io_in_1_ready,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_1_valid,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [2:0]  io_in_1_bits_opcode,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_in_1_bits_param,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [7:0]  io_in_1_bits_size,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_in_1_bits_source,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [63:0] io_in_1_bits_data,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_1_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [8:0]  io_in_1_bits_union,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_1_bits_last,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output        io_in_4_ready,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_4_valid,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [2:0]  io_in_4_bits_opcode,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_in_4_bits_param,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [7:0]  io_in_4_bits_size,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_in_4_bits_source,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [63:0] io_in_4_bits_address,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_in_4_bits_data,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_4_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input  [8:0]  io_in_4_bits_union,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  input         io_in_4_bits_last,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_out_ready,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output        io_out_valid,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output [2:0]  io_out_bits_chanId,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_out_bits_opcode,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_out_bits_param,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output [7:0]  io_out_bits_size,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_out_bits_source,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output [63:0] io_out_bits_address,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
                io_out_bits_data,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output        io_out_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output [8:0]  io_out_bits_union,	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
  output        io_out_bits_last	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14]
);

  wire [2:0]       _GEN = {1'h1, 1'h1, 1'h1};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [2:0][8:0]  _GEN_0 = {9'h0, 9'h0, 9'h0};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [2:0]       _GEN_1 = {1'h0, 1'h0, 1'h0};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [2:0][63:0] _GEN_2 = {64'h0, 64'h0, 64'h0};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [2:0][7:0]  _GEN_3 = {8'h0, 8'h0, 8'h0};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [2:0][2:0]  _GEN_4 = {3'h0, 3'h0, 3'h0};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [7:0][2:0]  _GEN_5 = {3'h4, 3'h4, 3'h4, 3'h0, 3'h1, 3'h2, 3'h3, 3'h4};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  reg  [2:0]       lockIdx;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24]
  reg              locked;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:27:23]
  wire [2:0]       _choice_T_2 = io_in_1_valid ? 3'h1 : 3'h4;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [2:0]       chosen = locked ? lockIdx : _choice_T_2;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24, :27:23, :37:19, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [7:0]       _GEN_6 = {_GEN_1, {{io_in_4_valid}, {1'h0}, {1'h0}, {io_in_1_valid}, {1'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [7:0][2:0]  _GEN_7 = {_GEN_4, {{io_in_4_bits_opcode}, {3'h0}, {3'h0}, {io_in_1_bits_opcode}, {3'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0][2:0]  _GEN_8 = {_GEN_4, {{io_in_4_bits_param}, {3'h0}, {3'h0}, {io_in_1_bits_param}, {3'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0][7:0]  _GEN_9 = {_GEN_3, {{io_in_4_bits_size}, {8'h0}, {8'h0}, {io_in_1_bits_size}, {8'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0][7:0]  _GEN_10 = {_GEN_3, {{io_in_4_bits_source}, {8'h0}, {8'h0}, {io_in_1_bits_source}, {8'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0][63:0] _GEN_11 = {_GEN_2, {{io_in_4_bits_address}, {64'h0}, {64'h0}, {64'h0}, {64'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0][63:0] _GEN_12 = {_GEN_2, {{io_in_4_bits_data}, {64'h0}, {64'h0}, {io_in_1_bits_data}, {64'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0]       _GEN_13 = {_GEN_1, {{io_in_4_bits_corrupt}, {1'h0}, {1'h0}, {io_in_1_bits_corrupt}, {1'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire [7:0][8:0]  _GEN_14 = {_GEN_0, {{io_in_4_bits_union}, {9'h0}, {9'h0}, {io_in_1_bits_union}, {9'h0}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :43:16]
  wire [7:0]       _GEN_15 = {_GEN, {{io_in_4_bits_last}, {1'h1}, {1'h1}, {io_in_1_bits_last}, {1'h1}}};	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:43:16]
  wire             _GEN_16 = io_out_ready & _GEN_6[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16, src/main/scala/chisel3/util/Decoupled.scala:52:35]
  always @(posedge clock) begin
    if (reset) begin
      lockIdx <= 3'h0;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :26:24]
      locked <= 1'h0;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:27:23]
    end
    else begin
      if (_GEN_16 & ~locked)	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24, :27:23, :59:22, :60:{11,50}, :61:15, src/main/scala/chisel3/util/Decoupled.scala:52:35]
        lockIdx <= _choice_T_2;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24, src/main/scala/chisel3/util/Mux.scala:50:70]
      if (_GEN_16)	// @[src/main/scala/chisel3/util/Decoupled.scala:52:35]
        locked <= ~_GEN_15[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:27:23, :37:19, :43:16, :60:50, :65:35, :66:14]
    end
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
        lockIdx = _RANDOM[/*Zero width*/ 1'b0][2:0];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24]
        locked = _RANDOM[/*Zero width*/ 1'b0][3];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:26:24, :27:23]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_1_ready = io_out_ready & chosen == 3'h1;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :37:19, :40:{36,46}]
  assign io_in_4_ready = io_out_ready & chosen == 3'h4;	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:14:14, :37:19, :40:{36,46}, src/main/scala/chisel3/util/Mux.scala:50:70]
  assign io_out_valid = _GEN_6[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_chanId = _GEN_5[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_opcode = _GEN_7[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_param = _GEN_8[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_size = _GEN_9[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_source = _GEN_10[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_address = _GEN_11[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_data = _GEN_12[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_corrupt = _GEN_13[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_union = _GEN_14[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
  assign io_out_bits_last = _GEN_15[chosen];	// @[generators/rocket-chip/src/main/scala/util/Arbiters.scala:37:19, :43:16]
endmodule

