`ifndef HANDSHAKE_IF_SV
`define HANDSHAKE_IF_SV

interface handshake_if();

  timeunit      1ns;
  timeprecision 1ps;

  import handshake_pkg::*;

  wire clk;
  wire [31:0] data;
  wire vld;
  wire rdy;

  clocking cb_drv @(posedge clk);
    input data;
    input vld;
    input rdy;
  endclocking : cb_drv

  clocking cb_mon @(posedge clk);
    input data;
    input vld;
    input rdy;
  endclocking : cb_mon

endinterface : handshake_if

`endif // HANDSHAKE_IF_SV
