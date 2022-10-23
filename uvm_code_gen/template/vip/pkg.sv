package {vip}_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "{vip}_tx.sv"
  `include "{vip}_config.sv"
  `include "{vip}_driver.sv"
  `include "{vip}_monitor.sv"
  `include "{vip}_sequencer.sv"
  `include "{vip}_coverage.sv"
  `include "{vip}_agent.sv"
  `include "{vip}_seq_lib.sv"

endpackage : {vip}_pkg
