`ifndef {upper_top}_TEST_PKG_SV
`define {upper_top}_TEST_PKG_SV

package {top}_test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

{vip_imports}
  import {top}_pkg::*;

  `include "{top}_test.sv"

endpackage : {top}_test_pkg

`endif // {upper_top}_TEST_PKG_SV
