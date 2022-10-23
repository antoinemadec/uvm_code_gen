`ifndef {upper_vip}_MONITOR_SV
`define {upper_vip}_MONITOR_SV

class {vip}_monitor extends uvm_monitor;

  `uvm_component_utils({vip}_monitor)

  virtual {vip}_if vif;

  {vip}_config m_config;

  uvm_analysis_port #({vip}_tx) analysis_port;

  {vip}_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : {vip}_monitor


function {vip}_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task {vip}_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = {vip}_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


task {vip}_monitor::do_mon();
  `uvm_fatal(get_type_name(), "TODO: fill do_mon()");
endtask : do_mon


`endif // {upper_vip}_MONITOR_SV
