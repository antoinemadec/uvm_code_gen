`ifndef FIFO_IN_CONFIG_SV
`define FIFO_IN_CONFIG_SV

class fifo_in_config extends uvm_object;

  // do not register config class with the factory

  virtual fifo_in_if vif;

  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;
  bit                      checks_enable;

  extern function new(string name = "");

endclass : fifo_in_config


function fifo_in_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // FIFO_IN_CONFIG_SV
