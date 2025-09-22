`include "params.vh"
`include "hash.sv"

module pre_encryption (
    input clk,
    input wire start,
    input wire rst,
    input wire [(KYBER_N)+(KYBER_K * KYBER_R_WIDTH * KYBER_N)-1:0] encryption_key,
    input wire [KYBER_N - 1:0] rand_in,
    output reg [KYBER_N - 1:0] msg,
    output reg [KYBER_N - 1:0] coin,
    output reg [KYBER_N - 1:0] pre_k,
    output reg valid
);

  // Internal variable between module
  wire sha3_valid0, sha3_valid1, sha3_valid2;
  wire [KYBER_N - 1:0] hash_ek;
  wire [(2 * KYBER_N) - 1:0] buf0; // store hash(ek),msg
  wire [(2 * KYBER_N) - 1:0] buf1; // store coin,pre_k

  // SHA modules declaration
  // get plain text message
  sha3_256 sha3_uut1 (
      .clk(clk),
      .in(rand_in),
      .out(msg),
      .valid(sha3_valid0)
  );

  // get hash(ek)
  sha3_256 #(
      .IN_WIDTH((KYBER_K * KYBER_R_WIDTH * KYBER_N) - 1)
  ) sha3_uut2 (
      .clk(clk),
      .in(encryption_key),
      .out(hash_ek),
      .valid(sha3_valid1)
  );

  sha3_512 sha3_uut3 (
      .clk(clk),
      .in(buf1),
      .out(buf2),
      .valid(sha3_valid2)
  );

  // Behavior of the module
  always @(posedge clk) begin
    ...
  end
endmodule

