`ifndef {upper_top}_CONFIG_SV
`define {upper_top}_CONFIG_SV

class {top}_config extends uvm_object;

  // do not register config class with the factory

{config_declarations}

  extern function new(string name = "");

endclass : {top}_config


function {top}_config::new(string name = "");
  super.new(name);

{config_new_core}
endfunction : new


`endif // {upper_top}_CONFIG_SV
