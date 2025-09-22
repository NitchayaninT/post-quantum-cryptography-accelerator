`include "params.vh"

// this module is combinational circuit
module decode_msg (
    input wire [`KYBER_N -1:0] msg,
    output reg [(`KYBER_N * `KYBER_R_WIDTH * `KYBER_K)-1:0] poly_msg
);

  integer i;
  always_comb begin
    for (i = 0; i < `KYBER_N; i++) begin
      if (msg[i] == 1) poly_msg[12*i+:12] = 12'b011010000001;
      else poly_msg[12*i+:12] = 12'b000000000000;
    end
  end
endmodule
