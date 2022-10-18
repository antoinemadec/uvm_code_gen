`ifndef {upper_vip_name}_IF_SV
`define {upper_vip_name}_IF_SV

interface {vip_name}_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import {vip_name}_pkg::*;

{ports}

endinterface : {vip_name}_if

`endif // {upper_vip_name}_IF_SV
