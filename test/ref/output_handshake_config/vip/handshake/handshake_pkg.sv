package handshake_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "handshake_tx.sv"
  `include "handshake_config.sv"
  `include "handshake_driver.sv"
  `include "handshake_master_driver.sv"
  `include "handshake_slave_driver.sv"
  `include "handshake_monitor.sv"
  `include "handshake_sequencer.sv"
  `include "handshake_coverage.sv"
  `include "handshake_agent.sv"
  `include "handshake_seq_lib.sv"

endpackage : handshake_pkg
