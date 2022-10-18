package {agent_name}_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "{agent_name}_tx.sv"
  `include "{agent_name}_config.sv"
  `include "{agent_name}_driver.sv"
  `include "{agent_name}_monitor.sv"
  `include "{agent_name}_sequencer.sv"
  `include "{agent_name}_coverage.sv"
  `include "{agent_name}_agent.sv"
  `include "{agent_name}_seq_lib.sv"

endpackage : {agent_name}_pkg
