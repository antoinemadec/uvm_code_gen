module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  logic clk = 0;
  logic rst;

  always #10 clk = ~clk;

  initial
  begin
    rst = 0;
    #75 rst = 1;
  end

  fifo_in_if fifo_in0_if();
  fifo_in_if fifo_in1_if();
  fifo_out_if fifo_out0_if();
  fifo_out_if fifo_out1_if();

  assign fifo_in0_if.clk = clk;
  assign fifo_in1_if.clk = clk;
  assign fifo_out0_if.clk = clk;
  assign fifo_out1_if.clk = clk;

  dut dut(
    .clk (clk),
    .rst (rst),
    .data_in (fifo_in0_if.data_in),
    .data_in_vld (fifo_in0_if.data_in_vld),
    .data_in_rdy (fifo_in0_if.data_in_rdy),
    .data_in (fifo_in1_if.data_in),
    .data_in_vld (fifo_in1_if.data_in_vld),
    .data_in_rdy (fifo_in1_if.data_in_rdy),
    .data_out (fifo_out0_if.data_out),
    .data_out_vld (fifo_out0_if.data_out_vld),
    .data_out_rdy (fifo_out0_if.data_out_rdy),
    .data_out (fifo_out1_if.data_out),
    .data_out_vld (fifo_out1_if.data_out_vld),
    .data_out_rdy (fifo_out1_if.data_out_rdy)
  );

endmodule
