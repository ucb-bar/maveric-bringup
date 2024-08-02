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

module TLSerdesser(
  input         clock,
                reset,
  output        auto_manager_in_a_ready,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_manager_in_a_valid,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [2:0]  auto_manager_in_a_bits_opcode,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_manager_in_a_bits_param,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_manager_in_a_bits_size,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [3:0]  auto_manager_in_a_bits_source,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [30:0] auto_manager_in_a_bits_address,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [7:0]  auto_manager_in_a_bits_mask,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [63:0] auto_manager_in_a_bits_data,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_manager_in_a_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_manager_in_d_ready,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        auto_manager_in_d_valid,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [2:0]  auto_manager_in_d_bits_opcode,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [1:0]  auto_manager_in_d_bits_param,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [2:0]  auto_manager_in_d_bits_size,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [3:0]  auto_manager_in_d_bits_source,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        auto_manager_in_d_bits_sink,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_manager_in_d_bits_denied,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [63:0] auto_manager_in_d_bits_data,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        auto_manager_in_d_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_client_out_a_ready,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        auto_client_out_a_valid,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [2:0]  auto_client_out_a_bits_opcode,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_client_out_a_bits_param,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_client_out_a_bits_size,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [3:0]  auto_client_out_a_bits_source,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [31:0] auto_client_out_a_bits_address,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [7:0]  auto_client_out_a_bits_mask,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output [63:0] auto_client_out_a_bits_data,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        auto_client_out_a_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
                auto_client_out_d_ready,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_client_out_d_valid,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [2:0]  auto_client_out_d_bits_opcode,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [1:0]  auto_client_out_d_bits_param,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [2:0]  auto_client_out_d_bits_size,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [3:0]  auto_client_out_d_bits_source,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [1:0]  auto_client_out_d_bits_sink,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_client_out_d_bits_denied,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input  [63:0] auto_client_out_d_bits_data,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  input         auto_client_out_d_bits_corrupt,	// @[generators/rocket-chip/src/main/scala/diplomacy/LazyModule.scala:367:18]
  output        io_ser_in_ready,	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
  input         io_ser_in_valid,	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
  input  [3:0]  io_ser_in_bits,	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
  input         io_ser_out_ready,	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
  output        io_ser_out_valid,	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
  output [3:0]  io_ser_out_bits	// @[generators/testchipip/src/main/scala/Serdes.scala:626:16]
);

  wire        _inDes_io_out_valid;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [2:0]  _inDes_io_out_bits_chanId;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [2:0]  _inDes_io_out_bits_opcode;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [2:0]  _inDes_io_out_bits_param;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [7:0]  _inDes_io_out_bits_size;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [7:0]  _inDes_io_out_bits_source;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [63:0] _inDes_io_out_bits_address;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [63:0] _inDes_io_out_bits_data;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire        _inDes_io_out_bits_corrupt;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire [8:0]  _inDes_io_out_bits_union;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  wire        _outSer_io_in_ready;	// @[generators/testchipip/src/main/scala/Serdes.scala:650:24]
  wire        _outArb_io_in_1_ready;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire        _outArb_io_in_4_ready;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire        _outArb_io_out_valid;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [2:0]  _outArb_io_out_bits_chanId;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [2:0]  _outArb_io_out_bits_opcode;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [2:0]  _outArb_io_out_bits_param;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [7:0]  _outArb_io_out_bits_size;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [7:0]  _outArb_io_out_bits_source;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [63:0] _outArb_io_out_bits_address;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [63:0] _outArb_io_out_bits_data;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire        _outArb_io_out_bits_corrupt;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [8:0]  _outArb_io_out_bits_union;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire        _outArb_io_out_bits_last;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  wire [12:0] _merged_bits_last_beats1_decode_T_1 = 13'h3F << auto_client_out_d_bits_size;	// @[generators/rocket-chip/src/main/scala/util/package.scala:235:71]
  wire [2:0]  merged_bits_last_beats1 = auto_client_out_d_bits_opcode[0] ? ~(_merged_bits_last_beats1_decode_T_1[5:3]) : 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:107:36, :222:14, generators/rocket-chip/src/main/scala/util/package.scala:235:{46,71,76}]
  reg  [2:0]  merged_bits_last_counter_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
  wire [12:0] _merged_bits_last_beats1_decode_T_13 = 13'h3F << auto_manager_in_a_bits_size;	// @[generators/rocket-chip/src/main/scala/util/package.scala:235:71]
  wire [2:0]  merged_bits_last_beats1_3 = auto_manager_in_a_bits_opcode[2] ? 3'h0 : ~(_merged_bits_last_beats1_decode_T_13[5:3]);	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:93:37, :222:14, generators/rocket-chip/src/main/scala/util/package.scala:235:{46,71,76}]
  reg  [2:0]  merged_bits_last_counter_4;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
  always @(posedge clock) begin
    if (reset) begin
      merged_bits_last_counter_1 <= 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
      merged_bits_last_counter_4 <= 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
    end
    else begin
      if (_outArb_io_in_1_ready & auto_client_out_d_valid) begin	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24, src/main/scala/chisel3/util/Decoupled.scala:52:35]
        if (merged_bits_last_counter_1 == 3'h0)	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27, :232:25]
          merged_bits_last_counter_1 <= merged_bits_last_beats1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:222:14, :230:27]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:232:25]
          merged_bits_last_counter_1 <= merged_bits_last_counter_1 - 3'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27, :231:28]
      end
      if (_outArb_io_in_4_ready & auto_manager_in_a_valid) begin	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24, src/main/scala/chisel3/util/Decoupled.scala:52:35]
        if (merged_bits_last_counter_4 == 3'h0)	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27, :232:25]
          merged_bits_last_counter_4 <= merged_bits_last_beats1_3;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:222:14, :230:27]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:232:25]
          merged_bits_last_counter_4 <= merged_bits_last_counter_4 - 3'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27, :231:28]
      end
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
        merged_bits_last_counter_1 = _RANDOM[/*Zero width*/ 1'b0][5:3];	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
        merged_bits_last_counter_4 = _RANDOM[/*Zero width*/ 1'b0][14:12];	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  HellaPeekingArbiter outArb (	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .clock                (clock),
    .reset                (reset),
    .io_in_1_ready        (_outArb_io_in_1_ready),
    .io_in_1_valid        (auto_client_out_d_valid),
    .io_in_1_bits_opcode  (auto_client_out_d_bits_opcode),
    .io_in_1_bits_param   ({1'h0, auto_client_out_d_bits_param}),	// @[generators/testchipip/src/main/scala/Serdes.scala:316:20]
    .io_in_1_bits_size    ({5'h0, auto_client_out_d_bits_size}),	// @[generators/testchipip/src/main/scala/Serdes.scala:317:20]
    .io_in_1_bits_source  ({4'h0, auto_client_out_d_bits_source}),	// @[generators/testchipip/src/main/scala/Serdes.scala:318:20]
    .io_in_1_bits_data    (auto_client_out_d_bits_data),
    .io_in_1_bits_corrupt (auto_client_out_d_bits_corrupt),
    .io_in_1_bits_union   ({6'h0, auto_client_out_d_bits_sink, auto_client_out_d_bits_denied}),	// @[generators/testchipip/src/main/scala/Serdes.scala:323:22]
    .io_in_1_bits_last    (merged_bits_last_counter_1 == 3'h1 | merged_bits_last_beats1 == 3'h0),	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:222:14, :230:27, :233:{25,33,43}]
    .io_in_4_ready        (_outArb_io_in_4_ready),
    .io_in_4_valid        (auto_manager_in_a_valid),
    .io_in_4_bits_opcode  (auto_manager_in_a_bits_opcode),
    .io_in_4_bits_param   (auto_manager_in_a_bits_param),
    .io_in_4_bits_size    ({5'h0, auto_manager_in_a_bits_size}),	// @[generators/testchipip/src/main/scala/Serdes.scala:260:20, :317:20]
    .io_in_4_bits_source  ({4'h0, auto_manager_in_a_bits_source}),	// @[generators/testchipip/src/main/scala/Serdes.scala:261:20, :318:20]
    .io_in_4_bits_address ({33'h0, auto_manager_in_a_bits_address}),	// @[generators/testchipip/src/main/scala/Serdes.scala:262:20]
    .io_in_4_bits_data    (auto_manager_in_a_bits_data),
    .io_in_4_bits_corrupt (auto_manager_in_a_bits_corrupt),
    .io_in_4_bits_union   ({1'h0, auto_manager_in_a_bits_mask}),	// @[generators/testchipip/src/main/scala/Serdes.scala:266:20]
    .io_in_4_bits_last    (merged_bits_last_counter_4 == 3'h1 | merged_bits_last_beats1_3 == 3'h0),	// @[generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:260:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:222:14, :230:27, :233:{25,33,43}]
    .io_out_ready         (_outSer_io_in_ready),	// @[generators/testchipip/src/main/scala/Serdes.scala:650:24]
    .io_out_valid         (_outArb_io_out_valid),
    .io_out_bits_chanId   (_outArb_io_out_bits_chanId),
    .io_out_bits_opcode   (_outArb_io_out_bits_opcode),
    .io_out_bits_param    (_outArb_io_out_bits_param),
    .io_out_bits_size     (_outArb_io_out_bits_size),
    .io_out_bits_source   (_outArb_io_out_bits_source),
    .io_out_bits_address  (_outArb_io_out_bits_address),
    .io_out_bits_data     (_outArb_io_out_bits_data),
    .io_out_bits_corrupt  (_outArb_io_out_bits_corrupt),
    .io_out_bits_union    (_outArb_io_out_bits_union),
    .io_out_bits_last     (_outArb_io_out_bits_last)
  );
  GenericSerializer outSer (	// @[generators/testchipip/src/main/scala/Serdes.scala:650:24]
    .clock              (clock),
    .reset              (reset),
    .io_in_ready        (_outSer_io_in_ready),
    .io_in_valid        (_outArb_io_out_valid),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_chanId  (_outArb_io_out_bits_chanId),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_opcode  (_outArb_io_out_bits_opcode),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_param   (_outArb_io_out_bits_param),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_size    (_outArb_io_out_bits_size),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_source  (_outArb_io_out_bits_source),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_address (_outArb_io_out_bits_address),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_data    (_outArb_io_out_bits_data),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_corrupt (_outArb_io_out_bits_corrupt),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_union   (_outArb_io_out_bits_union),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_in_bits_last    (_outArb_io_out_bits_last),	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
    .io_out_ready       (io_ser_out_ready),
    .io_out_valid       (io_ser_out_valid),
    .io_out_bits        (io_ser_out_bits)
  );
  GenericDeserializer inDes (	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
    .clock               (clock),
    .reset               (reset),
    .io_in_ready         (io_ser_in_ready),
    .io_in_valid         (io_ser_in_valid),
    .io_in_bits          (io_ser_in_bits),
    .io_out_ready        (_inDes_io_out_bits_chanId != 3'h4 & (_inDes_io_out_bits_chanId == 3'h3 ? auto_manager_in_d_ready : ~(_inDes_io_out_bits_chanId == 3'h2 | _inDes_io_out_bits_chanId == 3'h1) & ~(|_inDes_io_out_bits_chanId) & auto_client_out_a_ready)),	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:233:25, generators/testchipip/src/main/scala/Serdes.scala:238:37, :241:37, :335:20, :656:23, src/main/scala/chisel3/util/Mux.scala:77:13]
    .io_out_valid        (_inDes_io_out_valid),
    .io_out_bits_chanId  (_inDes_io_out_bits_chanId),
    .io_out_bits_opcode  (_inDes_io_out_bits_opcode),
    .io_out_bits_param   (_inDes_io_out_bits_param),
    .io_out_bits_size    (_inDes_io_out_bits_size),
    .io_out_bits_source  (_inDes_io_out_bits_source),
    .io_out_bits_address (_inDes_io_out_bits_address),
    .io_out_bits_data    (_inDes_io_out_bits_data),
    .io_out_bits_corrupt (_inDes_io_out_bits_corrupt),
    .io_out_bits_union   (_inDes_io_out_bits_union)
  );
  assign auto_manager_in_a_ready = _outArb_io_in_4_ready;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
  assign auto_manager_in_d_valid = _inDes_io_out_valid & _inDes_io_out_bits_chanId == 3'h3;	// @[generators/testchipip/src/main/scala/Serdes.scala:241:37, :656:23, :665:46]
  assign auto_manager_in_d_bits_opcode = _inDes_io_out_bits_opcode;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_manager_in_d_bits_param = _inDes_io_out_bits_param[1:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:404:15, :656:23]
  assign auto_manager_in_d_bits_size = _inDes_io_out_bits_size[2:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:376:15, :656:23]
  assign auto_manager_in_d_bits_source = _inDes_io_out_bits_source[3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:377:15, :656:23]
  assign auto_manager_in_d_bits_sink = _inDes_io_out_bits_union[1];	// @[generators/testchipip/src/main/scala/Serdes.scala:467:17, :656:23]
  assign auto_manager_in_d_bits_denied = _inDes_io_out_bits_union[0];	// @[generators/testchipip/src/main/scala/Serdes.scala:468:30, :656:23]
  assign auto_manager_in_d_bits_data = _inDes_io_out_bits_data;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_manager_in_d_bits_corrupt = _inDes_io_out_bits_corrupt;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_client_out_a_valid = _inDes_io_out_valid & ~(|_inDes_io_out_bits_chanId);	// @[generators/testchipip/src/main/scala/Serdes.scala:238:37, :656:23, :659:45]
  assign auto_client_out_a_bits_opcode = _inDes_io_out_bits_opcode;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_client_out_a_bits_param = _inDes_io_out_bits_param;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_client_out_a_bits_size = _inDes_io_out_bits_size[2:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:376:15, :656:23]
  assign auto_client_out_a_bits_source = _inDes_io_out_bits_source[3:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:377:15, :656:23]
  assign auto_client_out_a_bits_address = _inDes_io_out_bits_address[31:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:378:15, :656:23]
  assign auto_client_out_a_bits_mask = _inDes_io_out_bits_union[7:0];	// @[generators/testchipip/src/main/scala/Serdes.scala:384:15, :656:23]
  assign auto_client_out_a_bits_data = _inDes_io_out_bits_data;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_client_out_a_bits_corrupt = _inDes_io_out_bits_corrupt;	// @[generators/testchipip/src/main/scala/Serdes.scala:656:23]
  assign auto_client_out_d_ready = _outArb_io_in_1_ready;	// @[generators/testchipip/src/main/scala/Serdes.scala:648:24]
endmodule

