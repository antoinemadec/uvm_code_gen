`ifndef {upper_vip}_CONFIG_SV
`define {upper_vip}_CONFIG_SV

class {vip}_config extends uvm_object;

  // do not register config class with the factory

  virtual {vip}_if vif;

  uvm_active_passive_enum  is_active = UVM_ACTIVE;
{config_attribute_is_master}
  bit                      coverage_enable;
  bit                      checks_enable;

  extern function new(string name = "");

endclass : {vip}_config


function {vip}_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // {upper_vip}_CONFIG_SV
