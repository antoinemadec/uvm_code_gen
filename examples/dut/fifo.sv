module fifo (
  input clk,
  // data_in
  input [31:0] data_in,
  input        data_in_vld,
  output       data_in_rdy,
  // data_out
  output logic [15:0] data_out,
  output        data_out_vld,
  input         data_out_rdy
);

  localparam FIFO16_SIZE = 8;

  bit [15:0] q16[$];

  assign data_in_rdy = q16.size() <= (FIFO16_SIZE - 2);
  assign data_out_vld = (q16.size() > 0);

  always @(*) begin
    if (q16.size() > 0)
      data_out = q16[0];
    else
      data_out = 1'bX;
  end

  always_ff @(posedge clk) begin
    if (data_in_vld && data_in_rdy) begin
      q16.push_back(data_in[31:16]);
      q16.push_back(data_in[15:0]);
    end
    if (data_out_vld && data_out_rdy) begin
      void'(q16.pop_front());
    end
  end

endmodule
