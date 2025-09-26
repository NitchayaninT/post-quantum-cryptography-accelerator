// this module is combinational circuit
// main purpose to feed correct input to cla_adder module

`timescale 1ns / 1ps
`include "params.vh"

module multiplexer5x1 (
    input [1:0] selector,
    input [(`KYBER_N * 12) - 1 : 0] in0,
    input [(`KYBER_N * 12) - 1 : 0] in1,
    input [(`KYBER_N * 12) - 1 : 0] in2,
    input [(`KYBER_N * 12) - 1 : 0] in3,
    input [(`KYBER_N * 12) - 1 : 0] in4,
    output reg [(`KYBER_N * 12) - 1 : 0] out
);

  always_comb begin
    case (selector)
      0: out = {1'b0, in0};
      1: out = {1'b0, in1};
      2: out = {1'b0, in2};
      3: out = {1'b0, in3};
      default: out = 'x;
    endcase
  end
endmodule
