`ifndef AHB_IF_SV
`define AHB_IF_SV

interface ahb_if();

  timeunit      1ns;
  timeprecision 1ps;

  import ahb_pkg::*;

  HCLK
  HRESETn
  HADDR[31:0]
  HWRITE
  HSIZE[2:0]
  HBURST[2:0]
  HPROT[3:0]
  HPROT[6:4]
  HTRANS[1:0]
  HMASTLOCK
  HWDATA[31:0]
  HREADYOUT
  HRESP
  HRDATA[31:0]
  HSEL

  clocking cb_drv @(posedge HCLK);
    input HRESETn;
    input HADDR;
    input HWRITE;
    input HSIZE;
    input HBURST;
    input HPROT;
    input HPROT;
    input HTRANS;
    input HMASTLOCK;
    input HWDATA;
    input HREADYOUT;
    input HRESP;
    input HRDATA;
    input HSEL;
  endclocking : cb_drv

  clocking cb_mon @(posedge HCLK);
    input HRESETn;
    input HADDR;
    input HWRITE;
    input HSIZE;
    input HBURST;
    input HPROT;
    input HPROT;
    input HTRANS;
    input HMASTLOCK;
    input HWDATA;
    input HREADYOUT;
    input HRESP;
    input HRDATA;
    input HSEL;
  endclocking : cb_mon

endinterface : ahb_if

`endif // AHB_IF_SV
