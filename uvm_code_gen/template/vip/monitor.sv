`ifndef {upper_vip_name}_MONITOR_SV
`define {upper_vip_name}_MONITOR_SV

class {vip_name}_monitor extends uvm_monitor;

  `uvm_component_utils({vip_name}_monitor)

  virtual {vip_name}_if vif;

  {vip_name}_config m_config;

  uvm_analysis_port #({vip_name}_tx) analysis_port;

  {vip_name}_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : {vip_name}_monitor


function {vip_name}_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task {vip_name}_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = {vip_name}_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


task {vip_name}_monitor::do_mon();
  `uvm_fatal(get_type_name(), "TODO: fill do_mon()");
endtask : do_mon


`endif // {upper_vip_name}_MONITOR_SV
