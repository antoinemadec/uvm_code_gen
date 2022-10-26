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

  ahb_if ahb_m0_if();
  ahb_if ahb_m1_if();
  ahb_if ahb_m2_if();
  ahb_if ahb_m3_if();
  ahb_if ahb_s0_if();
  ahb_if ahb_s1_if();
  ahb_if ahb_s2_if();
  ahb_if ahb_s3_if();



  dut dut(
    .clk (clk),
    .rst (rst),

  );

endmodule
