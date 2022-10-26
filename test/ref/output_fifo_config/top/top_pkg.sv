package top_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import fifo_in_pkg::*;
  import fifo_out_pkg::*;

  `include "top_config.sv"
  `include "top_seq_lib.sv"
  `include "top_scoreboard.sv"
  `include "top_env.sv"

endpackage : top_pkg
