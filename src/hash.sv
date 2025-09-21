
module sha3_256 #(
    parameter int IN_WIDTH = KYBER_N
) (
    input clk,
    input wire [IN_WIDTH-1:0] in,
    output wire [KYBER_N:0] out,
    output wire valid  // use for signalling start stop signal
);
  // place holder
  assign out   = in;
  assign valid = 1;
endmodule

module sha3_512 #(
    parameter int IN_WIDTH = 2 * KYBER_N
) (
    input clk,
    input wire [IN_WIDTH-1:0] in,
    output reg [(2 * KYBER_N)-1:0] out,
    output reg valid  // use for signalling start stop signal
);
  assign out   = in;
  assign valid = 1;
endmodule

