module multiplication #(
  parameter WIDTH = 8
)(
  input  wire [WIDTH-1:0]  in1,
  input  wire [WIDTH-1:0]  in2,
  output reg  [(2*WIDTH)-1:0] out
);
  // Just place holder before optimize the multiplcation implementations
  always @(*) begin
      out = in1 * in2;
  end 
endmodule
