package {top}_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

{vip_imports}

  `include "{top}_config.sv"
  `include "{top}_seq_lib.sv"
  `include "{top}_scoreboard.sv"
  `include "{top}_env.sv"

endpackage : {top}_pkg
