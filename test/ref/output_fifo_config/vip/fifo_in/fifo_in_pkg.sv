package fifo_in_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "fifo_in_tx.sv"
  `include "fifo_in_config.sv"
  `include "fifo_in_driver.sv"
  `include "fifo_in_monitor.sv"
  `include "fifo_in_sequencer.sv"
  `include "fifo_in_coverage.sv"
  `include "fifo_in_agent.sv"
  `include "fifo_in_seq_lib.sv"

endpackage : fifo_in_pkg
