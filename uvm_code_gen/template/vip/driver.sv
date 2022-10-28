`ifndef {upper_vip}_DRIVER_SV
`define {upper_vip}_DRIVER_SV

class {vip}_driver extends uvm_driver #({vip}_tx);

  `uvm_component_utils({vip}_driver)

  virtual {vip}_if vif;

  {vip}_config m_config;

  extern function new(string name, uvm_component parent);

{driver_function_declaration}

endclass : {vip}_driver


function {vip}_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


{driver_function_implementation}


`endif // {upper_vip}_DRIVER_SV
