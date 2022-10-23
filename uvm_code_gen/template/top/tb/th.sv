module {top}_th;

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

{interface_instantiation}

{interface_clock_assign}

  dut dut(
    .clk (clk),
    .rst (rst),
{dut_instantiation}
  );

endmodule
