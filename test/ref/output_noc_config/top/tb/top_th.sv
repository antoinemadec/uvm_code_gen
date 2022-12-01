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

  ahb_if ahb_if();

  assign ahb_if.HCLK = clk;

  dut dut(
    .clk (clk),
    .rstn (rstn),
    .HRESETn (ahb_if.HRESETn),
    .HADDR (ahb_if.HADDR),
    .HWRITE (ahb_if.HWRITE),
    .HSIZE (ahb_if.HSIZE),
    .HBURST (ahb_if.HBURST),
    .HPROT (ahb_if.HPROT),
    .HPROT (ahb_if.HPROT),
    .HTRANS (ahb_if.HTRANS),
    .HMASTLOCK (ahb_if.HMASTLOCK),
    .HWDATA (ahb_if.HWDATA),
    .HREADYOUT (ahb_if.HREADYOUT),
    .HRESP (ahb_if.HRESP),
    .HRDATA (ahb_if.HRDATA),
    .HSEL (ahb_if.HSEL)
  );

endmodule
