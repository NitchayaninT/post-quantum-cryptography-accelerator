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
    input [(`KYBER_N * `KYBER_R_WIDTH)-1:0] poly_msg,
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) -1 : 0] e_1[3],
    input [(`KYBER_N * `KYBER_SPOLY_WIDTH) -1 : 0] e_2,
    output [(`KYBER_N * 16) - 1 : 0] u[3],
    output [(`KYBER_N * 16) - 1 : 0] v
);

   reg [2:0] sel;
   multiplexer4x4 uut0(
     .selector(sel),
     .in0(x[0]),
     .in1(x[1]),
     .in2(x[2]),
     .in3(y),
     .in4(v)
     );
  reg [(`KYBER_N * 16) - 1 : 0] buffer[3] = 0;
  // Only use on set of module

  genvar i;
  for (i = 0; i < 255; i = i + 1) begin : g_cla_adder
    cla_adder cla_adder[i](
      .in1(buffer[0]),
      .in2(buffer[1]),
      .carry_in(0),
      .sum(buffer[2])
      );
  end

  always @(posedge clk) begin
    if (enable) begin
      case (state)
        2'b00 : begin
          buffer[0] = y;
          buffer[1] = x[0];
          buffer[2] = v;


        end
        default : e_1 <= z;
      endcase

    end
  end
endmodule
