`ifndef {upper_agent_name}_CONFIG_SV
`define {upper_agent_name}_CONFIG_SV

class {agent_name}_config extends uvm_object;
  // Do not register config class with the factory

  virtual {agent_name}_if vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  extern function new(string name = "");

endclass : {agent_name}_config 


function {agent_name}_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // {upper_agent_name}_CONFIG_SV
