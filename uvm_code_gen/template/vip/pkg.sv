package {vip_name}_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "{vip_name}_tx.sv"
  `include "{vip_name}_config.sv"
  `include "{vip_name}_driver.sv"
  `include "{vip_name}_monitor.sv"
  `include "{vip_name}_sequencer.sv"
  `include "{vip_name}_coverage.sv"
  `include "{vip_name}_agent.sv"
  `include "{vip_name}_seq_lib.sv"

endpackage : {vip_name}_pkg
