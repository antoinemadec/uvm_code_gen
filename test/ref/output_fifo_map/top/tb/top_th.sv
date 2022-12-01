module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  logic clk = 0;
  logic rstn;

  always #10 clk = ~clk;

  initial
  begin
    rstn = 0;
    #75 rstn = 1;
  end

  fifo_in_if fifo_in0_if();
  fifo_in_if fifo_in1_if();
  fifo_out_if fifo_out0_if();
  fifo_out_if fifo_out1_if();



  dut dut(
    .clk (clk),
    .rstn (rstn),

  );

endmodule
