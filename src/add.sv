`timescale 1ns / 1ps
`include "params.vh"

// use carry look ahead adder with 12 bits input 13 bits output
// each coefficient in polynomial ring use on cla_adder
// total of 256 cla_adder
// 4rounds of addition is made and then copy value from buffer to output
module add (
    input clk,
    input enable,
    input [(`KYBER_N * 16) - 1 : 0] x[3],  // old syntax is x[0:2]
    input [(`KYBER_N * 16) - 1 : 0] y,
    input [(`KYBER_N * `KYBER_R_WIDTH)-1:0] msg_poly,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) -1 : 0] e_1[3],
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) -1 : 0] e_2,
    output reg [(`KYBER_N * 16) - 1 : 0] u[3],
    output reg [(`KYBER_N * 16) - 1 : 0] v
);

  reg [(`KYBER_N * 12) - 1 : 0] in_buf0, in_buf1;
  reg [(`KYBER_N * 13) - 1 : 0] out_buf;

  reg[2:0] state;

  multiplexer5x1 mux_uut(
    .in0(x[0]),
    .in1(x[1]),
    .in2(x[2]),
    .in3(y),
    .in4(v),
    .out(in_buf0)
    );

  multiplexer5x1_small mux_small_uut(
    .in0(e_1[0]),
    .in1(e_1[1]),
    .in2(e_1[2]),
    .in3(e_2),
    .in4(msg_poly),
    .out(in_buf1)
    );
  // This is cla_adder for compute y + msg_poly
  cla_adder cla_adder0 (
      .in1(in_buf0),
      .in2(in_buf1),
      .sum(out_buf)
  );

  genvar i;
  always @(posedge clk) begin
    if (enable) begin
      case (state)
        3'd0: begin
          v = buffer;
          state = 3'd1;
        end
        default: e_1 <= z;
      endcase

    end
  end
endmodule
