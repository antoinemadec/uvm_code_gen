module {top}_th;

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

{interface_instantiation}

{interface_clock_assign}

  dut dut(
    .clk (clk),
    .rstn (rstn),
{dut_instantiation}
  );

endmodule
