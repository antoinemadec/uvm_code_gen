`ifndef {upper_top_name}_TEST_PKG_SV
`define {upper_top_name}_TEST_PKG_SV

package {top_name}_test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

{vip_imports}
  import {top_name}_pkg::*;

  `include "{top_name}_test.sv"

endpackage : {top_name}_test_pkg

`endif // {upper_top_name}_TEST_PKG_SV
