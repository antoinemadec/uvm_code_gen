`ifndef {upper_agent_name}_IF_SV
`define {upper_agent_name}_IF_SV

interface {agent_name}_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import {agent_name}_pkg::*;

{ports}

endinterface : {agent_name}_if

`endif // {upper_agent_name}_IF_SV
