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

module GenericDeserializer(
  input         clock,
                reset,
  output        io_in_ready,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  input         io_in_valid,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  input  [3:0]  io_in_bits,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  input         io_out_ready,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output        io_out_valid,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output [2:0]  io_out_bits_chanId,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
                io_out_bits_opcode,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
                io_out_bits_param,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output [7:0]  io_out_bits_size,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
                io_out_bits_source,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output [63:0] io_out_bits_address,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
                io_out_bits_data,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output        io_out_bits_corrupt,	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
  output [8:0]  io_out_bits_union	// @[generators/testchipip/src/main/scala/Serdes.scala:195:14]
);

  reg  [3:0] data_0;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_1;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_2;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_3;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_4;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_5;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_6;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_7;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_8;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_9;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_10;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_11;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_12;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_13;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_14;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_15;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_16;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_17;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_18;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_19;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_20;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_21;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_22;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_23;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_24;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_25;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_26;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_27;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_28;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_29;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_30;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_31;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_32;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_33;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_34;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_35;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_36;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_37;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_38;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_39;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg  [3:0] data_40;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
  reg        receiving;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26]
  reg  [5:0] recvCount;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  wire       wrap_wrap = recvCount == 6'h28;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :73:24]
  wire       _GEN = receiving & io_in_valid;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26, src/main/scala/chisel3/util/Decoupled.scala:52:35]
  always @(posedge clock) begin
    if (_GEN & recvCount == 6'h0)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_0 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_1 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h2)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_2 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h3)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_3 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h4)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_4 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h5)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_5 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h6)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_6 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h7)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_7 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h8)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_8 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h9)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_9 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hA)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_10 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hB)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_11 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hC)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_12 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hD)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_13 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hE)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_14 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'hF)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_15 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h10)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_16 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h11)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_17 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h12)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_18 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h13)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_19 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h14)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_20 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h15)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_21 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h16)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_22 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h17)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_23 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h18)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_24 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h19)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_25 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1A)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_26 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1B)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_27 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1C)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_28 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1D)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_29 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1E)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_30 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h1F)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_31 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h20)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_32 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h21)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_33 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h22)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_34 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h23)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_35 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h24)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_36 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h25)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_37 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h26)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_38 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h27)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_39 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (_GEN & recvCount == 6'h28)	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :213:21, :214:21, src/main/scala/chisel3/util/Counter.scala:61:40, :73:24, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      data_40 <= io_in_bits;	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
    if (reset) begin
      receiving <= 1'h1;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26]
      recvCount <= 6'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
    end
    else begin
      receiving <= io_out_ready & ~receiving | ~(_GEN & wrap_wrap) & receiving;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26, :209:19, :217:{19,31}, :219:{22,34}, src/main/scala/chisel3/util/Counter.scala:73:24, :117:24, :118:{16,23}, src/main/scala/chisel3/util/Decoupled.scala:52:35]
      if (_GEN) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:52:35]
        if (wrap_wrap)	// @[src/main/scala/chisel3/util/Counter.scala:73:24]
          recvCount <= 6'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
        else	// @[src/main/scala/chisel3/util/Counter.scala:73:24]
          recvCount <= recvCount + 6'h1;	// @[generators/testchipip/src/main/scala/Serdes.scala:214:21, src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:5];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        data_0 = _RANDOM[3'h0][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_1 = _RANDOM[3'h0][7:4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_2 = _RANDOM[3'h0][11:8];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_3 = _RANDOM[3'h0][15:12];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_4 = _RANDOM[3'h0][19:16];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_5 = _RANDOM[3'h0][23:20];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_6 = _RANDOM[3'h0][27:24];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_7 = _RANDOM[3'h0][31:28];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_8 = _RANDOM[3'h1][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_9 = _RANDOM[3'h1][7:4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_10 = _RANDOM[3'h1][11:8];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_11 = _RANDOM[3'h1][15:12];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_12 = _RANDOM[3'h1][19:16];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_13 = _RANDOM[3'h1][23:20];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_14 = _RANDOM[3'h1][27:24];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_15 = _RANDOM[3'h1][31:28];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_16 = _RANDOM[3'h2][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_17 = _RANDOM[3'h2][7:4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_18 = _RANDOM[3'h2][11:8];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_19 = _RANDOM[3'h2][15:12];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_20 = _RANDOM[3'h2][19:16];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_21 = _RANDOM[3'h2][23:20];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_22 = _RANDOM[3'h2][27:24];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_23 = _RANDOM[3'h2][31:28];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_24 = _RANDOM[3'h3][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_25 = _RANDOM[3'h3][7:4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_26 = _RANDOM[3'h3][11:8];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_27 = _RANDOM[3'h3][15:12];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_28 = _RANDOM[3'h3][19:16];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_29 = _RANDOM[3'h3][23:20];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_30 = _RANDOM[3'h3][27:24];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_31 = _RANDOM[3'h3][31:28];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_32 = _RANDOM[3'h4][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_33 = _RANDOM[3'h4][7:4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_34 = _RANDOM[3'h4][11:8];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_35 = _RANDOM[3'h4][15:12];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_36 = _RANDOM[3'h4][19:16];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_37 = _RANDOM[3'h4][23:20];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_38 = _RANDOM[3'h4][27:24];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_39 = _RANDOM[3'h4][31:28];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        data_40 = _RANDOM[3'h5][3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17]
        receiving = _RANDOM[3'h5][4];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :205:26]
        recvCount = _RANDOM[3'h5][10:5];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, src/main/scala/chisel3/util/Counter.scala:61:40]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_ready = receiving;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26]
  assign io_out_valid = ~receiving;	// @[generators/testchipip/src/main/scala/Serdes.scala:205:26, :209:19]
  assign io_out_bits_chanId = data_40[3:1];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_opcode = {data_40[0], data_39[3:2]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_param = {data_39[1:0], data_38[3]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_size = {data_38[2:0], data_37, data_36[3]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_source = {data_36[2:0], data_35, data_34[3]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_address = {data_34[2:0], data_33, data_32, data_31, data_30, data_29, data_28, data_27, data_26, data_25, data_24, data_23, data_22, data_21, data_20, data_19, data_18[3]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_data = {data_18[2:0], data_17, data_16, data_15, data_14, data_13, data_12, data_11, data_10, data_9, data_8, data_7, data_6, data_5, data_4, data_3, data_2[3]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_corrupt = data_2[2];	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
  assign io_out_bits_union = {data_2[1:0], data_1, data_0[3:1]};	// @[generators/testchipip/src/main/scala/Serdes.scala:203:17, :210:38]
endmodule

