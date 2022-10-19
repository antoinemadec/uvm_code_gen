`ifndef TOP_TEST_PKG_SV
`define TOP_TEST_PKG_SV

package top_test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import fifo_in_pkg::*;
  import fifo_out_pkg::*;
  import top_pkg::*;

  `include "top_test.sv"

endpackage : top_test_pkg

`endif // TOP_TEST_PKG_SV

