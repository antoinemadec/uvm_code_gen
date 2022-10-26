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

  assign ahb_m0_if.HCLK = clk;
  assign ahb_m1_if.HCLK = clk;
  assign ahb_m2_if.HCLK = clk;
  assign ahb_m3_if.HCLK = clk;
  assign ahb_s0_if.HCLK = clk;
  assign ahb_s1_if.HCLK = clk;
  assign ahb_s2_if.HCLK = clk;
  assign ahb_s3_if.HCLK = clk;

  dut dut(
    .clk (clk),
    .rst (rst),
    .HRESETn (ahb_m0_if.HRESETn),
    .HADDR (ahb_m0_if.HADDR),
    .HWRITE (ahb_m0_if.HWRITE),
    .HSIZE (ahb_m0_if.HSIZE),
    .HBURST (ahb_m0_if.HBURST),
    .HPROT (ahb_m0_if.HPROT),
    .HPROT (ahb_m0_if.HPROT),
    .HTRANS (ahb_m0_if.HTRANS),
    .HMASTLOCK (ahb_m0_if.HMASTLOCK),
    .HWDATA (ahb_m0_if.HWDATA),
    .HREADYOUT (ahb_m0_if.HREADYOUT),
    .HRESP (ahb_m0_if.HRESP),
    .HRDATA (ahb_m0_if.HRDATA),
    .HSEL (ahb_m0_if.HSEL),
    .HRESETn (ahb_m1_if.HRESETn),
    .HADDR (ahb_m1_if.HADDR),
    .HWRITE (ahb_m1_if.HWRITE),
    .HSIZE (ahb_m1_if.HSIZE),
    .HBURST (ahb_m1_if.HBURST),
    .HPROT (ahb_m1_if.HPROT),
    .HPROT (ahb_m1_if.HPROT),
    .HTRANS (ahb_m1_if.HTRANS),
    .HMASTLOCK (ahb_m1_if.HMASTLOCK),
    .HWDATA (ahb_m1_if.HWDATA),
    .HREADYOUT (ahb_m1_if.HREADYOUT),
    .HRESP (ahb_m1_if.HRESP),
    .HRDATA (ahb_m1_if.HRDATA),
    .HSEL (ahb_m1_if.HSEL),
    .HRESETn (ahb_m2_if.HRESETn),
    .HADDR (ahb_m2_if.HADDR),
    .HWRITE (ahb_m2_if.HWRITE),
    .HSIZE (ahb_m2_if.HSIZE),
    .HBURST (ahb_m2_if.HBURST),
    .HPROT (ahb_m2_if.HPROT),
    .HPROT (ahb_m2_if.HPROT),
    .HTRANS (ahb_m2_if.HTRANS),
    .HMASTLOCK (ahb_m2_if.HMASTLOCK),
    .HWDATA (ahb_m2_if.HWDATA),
    .HREADYOUT (ahb_m2_if.HREADYOUT),
    .HRESP (ahb_m2_if.HRESP),
    .HRDATA (ahb_m2_if.HRDATA),
    .HSEL (ahb_m2_if.HSEL),
    .HRESETn (ahb_m3_if.HRESETn),
    .HADDR (ahb_m3_if.HADDR),
    .HWRITE (ahb_m3_if.HWRITE),
    .HSIZE (ahb_m3_if.HSIZE),
    .HBURST (ahb_m3_if.HBURST),
    .HPROT (ahb_m3_if.HPROT),
    .HPROT (ahb_m3_if.HPROT),
    .HTRANS (ahb_m3_if.HTRANS),
    .HMASTLOCK (ahb_m3_if.HMASTLOCK),
    .HWDATA (ahb_m3_if.HWDATA),
    .HREADYOUT (ahb_m3_if.HREADYOUT),
    .HRESP (ahb_m3_if.HRESP),
    .HRDATA (ahb_m3_if.HRDATA),
    .HSEL (ahb_m3_if.HSEL),
    .HRESETn (ahb_s0_if.HRESETn),
    .HADDR (ahb_s0_if.HADDR),
    .HWRITE (ahb_s0_if.HWRITE),
    .HSIZE (ahb_s0_if.HSIZE),
    .HBURST (ahb_s0_if.HBURST),
    .HPROT (ahb_s0_if.HPROT),
    .HPROT (ahb_s0_if.HPROT),
    .HTRANS (ahb_s0_if.HTRANS),
    .HMASTLOCK (ahb_s0_if.HMASTLOCK),
    .HWDATA (ahb_s0_if.HWDATA),
    .HREADYOUT (ahb_s0_if.HREADYOUT),
    .HRESP (ahb_s0_if.HRESP),
    .HRDATA (ahb_s0_if.HRDATA),
    .HSEL (ahb_s0_if.HSEL),
    .HRESETn (ahb_s1_if.HRESETn),
    .HADDR (ahb_s1_if.HADDR),
    .HWRITE (ahb_s1_if.HWRITE),
    .HSIZE (ahb_s1_if.HSIZE),
    .HBURST (ahb_s1_if.HBURST),
    .HPROT (ahb_s1_if.HPROT),
    .HPROT (ahb_s1_if.HPROT),
    .HTRANS (ahb_s1_if.HTRANS),
    .HMASTLOCK (ahb_s1_if.HMASTLOCK),
    .HWDATA (ahb_s1_if.HWDATA),
    .HREADYOUT (ahb_s1_if.HREADYOUT),
    .HRESP (ahb_s1_if.HRESP),
    .HRDATA (ahb_s1_if.HRDATA),
    .HSEL (ahb_s1_if.HSEL),
    .HRESETn (ahb_s2_if.HRESETn),
    .HADDR (ahb_s2_if.HADDR),
    .HWRITE (ahb_s2_if.HWRITE),
    .HSIZE (ahb_s2_if.HSIZE),
    .HBURST (ahb_s2_if.HBURST),
    .HPROT (ahb_s2_if.HPROT),
    .HPROT (ahb_s2_if.HPROT),
    .HTRANS (ahb_s2_if.HTRANS),
    .HMASTLOCK (ahb_s2_if.HMASTLOCK),
    .HWDATA (ahb_s2_if.HWDATA),
    .HREADYOUT (ahb_s2_if.HREADYOUT),
    .HRESP (ahb_s2_if.HRESP),
    .HRDATA (ahb_s2_if.HRDATA),
    .HSEL (ahb_s2_if.HSEL),
    .HRESETn (ahb_s3_if.HRESETn),
    .HADDR (ahb_s3_if.HADDR),
    .HWRITE (ahb_s3_if.HWRITE),
    .HSIZE (ahb_s3_if.HSIZE),
    .HBURST (ahb_s3_if.HBURST),
    .HPROT (ahb_s3_if.HPROT),
    .HPROT (ahb_s3_if.HPROT),
    .HTRANS (ahb_s3_if.HTRANS),
    .HMASTLOCK (ahb_s3_if.HMASTLOCK),
    .HWDATA (ahb_s3_if.HWDATA),
    .HREADYOUT (ahb_s3_if.HREADYOUT),
    .HRESP (ahb_s3_if.HRESP),
    .HRDATA (ahb_s3_if.HRDATA),
    .HSEL (ahb_s3_if.HSEL)
  );

endmodule
