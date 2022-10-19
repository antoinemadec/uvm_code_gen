`ifndef {upper_vip_name}_CONFIG_SV
`define {upper_vip_name}_CONFIG_SV

class {vip_name}_config extends uvm_object;

  // do not register config class with the factory

  virtual {vip_name}_if vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  extern function new(string name = "");

endclass : {vip_name}_config 


function {vip_name}_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // {upper_vip_name}_CONFIG_SV
