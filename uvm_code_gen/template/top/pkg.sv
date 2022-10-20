package {top_name}_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

{vip_imports}

  `include "{top_name}_config.sv"
  `include "{top_name}_seq_lib.sv"
  `include "{top_name}_scoreboard.sv"
  `include "{top_name}_env.sv"

endpackage : {top_name}_pkg
