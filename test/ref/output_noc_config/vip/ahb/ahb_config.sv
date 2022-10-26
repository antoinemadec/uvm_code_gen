`ifndef AHB_CONFIG_SV
`define AHB_CONFIG_SV

class ahb_config extends uvm_object;

  // do not register config class with the factory

  virtual ahb_if vif;

  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;
  bit                      checks_enable;

  extern function new(string name = "");

endclass : ahb_config


function ahb_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // AHB_CONFIG_SV
