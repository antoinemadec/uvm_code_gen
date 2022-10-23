`ifndef {upper_vip}_IF_SV
`define {upper_vip}_IF_SV

interface {vip}_if();

  timeunit      1ns;
  timeprecision 1ps;

  import {vip}_pkg::*;

  {clock_definition}
{ports_definition}

{clocking_blocks}

endinterface : {vip}_if

`endif // {upper_vip}_IF_SV
