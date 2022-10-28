`ifndef HANDSHAKE_MONITOR_SV
`define HANDSHAKE_MONITOR_SV

class handshake_monitor extends uvm_monitor;

  `uvm_component_utils(handshake_monitor)

  virtual handshake_if vif;

  handshake_config m_config;

  uvm_analysis_port #(handshake_tx) analysis_port;

  handshake_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : handshake_monitor


function handshake_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task handshake_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = handshake_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


task handshake_monitor::do_mon();
  `uvm_fatal(get_type_name(), "TODO: fill do_mon()");
endtask : do_mon


`endif // HANDSHAKE_MONITOR_SV
