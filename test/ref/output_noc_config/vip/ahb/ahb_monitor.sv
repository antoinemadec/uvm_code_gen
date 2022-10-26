`ifndef AHB_MONITOR_SV
`define AHB_MONITOR_SV

class ahb_monitor extends uvm_monitor;

  `uvm_component_utils(ahb_monitor)

  virtual ahb_if vif;

  ahb_config m_config;

  uvm_analysis_port #(ahb_tx) analysis_port;

  ahb_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : ahb_monitor


function ahb_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task ahb_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = ahb_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


task ahb_monitor::do_mon();
  `uvm_fatal(get_type_name(), "TODO: fill do_mon()");
endtask : do_mon


`endif // AHB_MONITOR_SV
