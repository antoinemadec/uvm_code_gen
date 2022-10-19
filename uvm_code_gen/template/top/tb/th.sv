module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // Example clock and reset declarations
  logic clock = 0;
  logic reset;

  // Example clock generator process
  always #10 clock = ~clock;

  // Example reset generator process
  initial
  begin
    reset = 0;         // Active low reset in this example
    #75 reset = 1;
  end

  assign fifo_in_if_0.clk  = clock;
  assign fifo_out_if_0.clk = clock;

  // Pin-level interfaces connected to DUT
  fifo_in_if   fifo_in_if_0 (); 
  fifo_out_if  fifo_out_if_0 ();

  fifo fifo (
    .clk         (clk),
    .data_in     (fifo_in_if_0.data_in),
    .data_in_vld (fifo_in_if_0.data_in_vld),
    .data_in_rdy (fifo_in_if_0.data_in_rdy),
    .data_out    (fifo_out_if_0.data_out),
    .data_out_vld(fifo_out_if_0.data_out_vld),
    .data_out_rdy(fifo_out_if_0.data_out_rdy)
  );

endmodule

