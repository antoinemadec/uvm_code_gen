`ifndef HANDSHAKE_CONFIG_SV
`define HANDSHAKE_CONFIG_SV

class handshake_config extends uvm_object;

  // do not register config class with the factory

  virtual handshake_if vif;

  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      is_master;
  bit                      coverage_enable;
  bit                      checks_enable;

  extern function new(string name = "");

endclass : handshake_config


function handshake_config::new(string name = "");
  super.new(name);
endfunction : new


`endif // HANDSHAKE_CONFIG_SV
