// this module is combinational circuit
// main purpose to feed correct input to cla_adder module

`timescale 1ns / 1ps
`include "params.vh"

// This is variation of mutiplexer that can recieve small polynomials
// except in4 will be normal polynomial

// KYBER_N = 256
// KYBER_SPOLY_WIDTH = 3
// KYBER_COEf_WIDTH = 12
module multiplexer_small (
    input [2:0] selector,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) - 1 : 0] in0,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) - 1 : 0] in1,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) - 1 : 0] in2,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) - 1 : 0] in3,
    input [(`KYBER_N * `KYBER_R_WIDTH) - 1 : 0] in4, // normal size polynomials
    output reg [(`KYBER_N * `KYBER_ARITH_WIDTH) - 1 : 0] out
);

  genvar i;
  always_comb begin
    case (selector)
      0: begin
        for (i = 0; i < `KYBER_N ; i++) begin

        end
      end
      1: out = in1;
      2: out = in2;
      3: out = in3;
      4: out = in4;
      default out = 'x;
    endcase
  end
endmodule
