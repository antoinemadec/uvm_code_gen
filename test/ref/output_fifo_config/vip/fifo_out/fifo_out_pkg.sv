package fifo_out_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "fifo_out_tx.sv"
  `include "fifo_out_config.sv"
  `include "fifo_out_driver.sv"
  `include "fifo_out_monitor.sv"
  `include "fifo_out_sequencer.sv"
  `include "fifo_out_coverage.sv"
  `include "fifo_out_agent.sv"
  `include "fifo_out_seq_lib.sv"

endpackage : fifo_out_pkg
