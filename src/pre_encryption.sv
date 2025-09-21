`include "params.vh"
`include "hash.sv"

module pre_encryption (
    input clk,
    input wire start,
    input wire [(KYBER_N)+(KYBER_K * KYBER_R_WIDTH * KYBER_N):0] encryption_key,
    input wire [KYBER_N:0] rand_in,
    output reg [KYBER_N:0] msg,
    output reg [KYBER_N:0] coin,
    output reg [KYBER_N:0] pre_k,
    output reg valid
);

  reg [KYBER_N:0] hash_ek;
  reg [1:0] state = 2'b00;
  reg [511:0] buf1;
  reg [511:0] buf2;
  always @(posedge clk) begin
    case (state)
      0:
      if (start) begin
        sha3_256 sha3_uut1 (
            .in(rand_in),
            .out(msg),
            .valid(flag)
        );
        if (flag == 1) begin
          state <= 2'b01;
          flag  <= 0;
        end
      end

      1: begin
        sha3_256 #(
            .IN_WIDTH((KYBER_K * KYBER_R_WIDTH * KYBER_N) - 1)
        ) sha3_uut2 (
            .in(encryption_key),
            .out(hash_ek),
            .valid(flag)
        );
        buf1[511:256] <= hash_ek;
        buf1[255:0]   <= msg;
        if (flag <= 1) begin
          state <= 2'b10;
          flag = 0;
        end
      end

      2: begin
          sha3_512 sha3_uut3 (
              .in (buf1),
              .out(buf2),
              .valid(flag)
          );
          if(flag == 1) begin
            state = 4;
            flag = 0;
          end
      end

      default begin
        valid <= 0;
      end
    endcase
  end

  assign coin  = buf2[511:0];
  assign pre_k = buf2[255:0];

endmodule

