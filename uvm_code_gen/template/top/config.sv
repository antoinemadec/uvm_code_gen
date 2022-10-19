`ifndef {upper_top_name}_CONFIG_SV
`define {upper_top_name}_CONFIG_SV

class {top_name}_config extends uvm_object;

  // do not register config class with the factory

{config_declarations}

  extern function new(string name = "");

endclass : {top_name}_config 


function {top_name}_config::new(string name = "");
  super.new(name);

{config_new_core}
endfunction : new


`endif // {upper_top_name}_CONFIG_SV
