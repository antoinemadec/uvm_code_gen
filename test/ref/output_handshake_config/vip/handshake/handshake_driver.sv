`ifndef HANDSHAKE_DRIVER_SV
`define HANDSHAKE_DRIVER_SV

class handshake_driver extends uvm_driver #(handshake_tx);

  `uvm_component_utils(handshake_driver)

  virtual handshake_if vif;

  handshake_config m_config;

  extern function new(string name, uvm_component parent);



endclass : handshake_driver


function handshake_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new





`endif // HANDSHAKE_DRIVER_SV
