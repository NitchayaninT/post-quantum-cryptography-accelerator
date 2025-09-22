`timescale 1ns / 1ps
`include "params.vh"

module decode_msg_tb;

  // test signal
  reg [`KYBER_N - 1:0] msg;
  reg [(`KYBER_N * `KYBER_R_WIDTH)-1:0] poly_msg;

  decode_msg uut (
      .msg(msg),
      .poly_msg(poly_msg)
  );

  initial begin
    msg = 0;

    //test vector
    #10 msg = 12'h3FA;
    #10 msg = 12'h001;
    #10 msg = 12'h1B4;
  end

  initial begin
    $monitor("%0t\t%h\t%h", $time, msg, poly_msg);
    $dumpfile("decode_msg.vcd");  // VCD file name
    $dumpvars(0, decode_msg_tb);  // Dump all signals in the testbench
  end
endmodule
