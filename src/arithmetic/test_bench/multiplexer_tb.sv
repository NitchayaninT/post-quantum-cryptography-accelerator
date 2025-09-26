`timescale 1ns / 1ps
`include "params.vh"

module multiplexer4x4_tb ();
  reg [2:0] selector;
  reg [(`KYBER_N * 16) - 1 : 0] in[0:4];
  reg [(`KYBER_N * 16) - 1 : 0] out;

  multiplexer4x4 uut (
      .selector(selector),
      .in(in),
      .out(out)
  );

  integer i;
  initial begin
    $readmemh("rand_poly.hex", in);

    #(`DELAY) selector = 3'b000;
    #(`DELAY) selector = 3'b001;
    #(`DELAY) selector = 3'b010;
    #(`DELAY) selector = 3'b011;
    #(`DELAY) selector = 3'b100;
    #(`DELAY) $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, multiplexer4x4_tb);
    $monitor("%t: sel = %b, output %h",$time,selector,out);
  end
endmodule
