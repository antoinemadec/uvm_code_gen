`ifndef {upper_agent_name}_MONITOR_SV
`define {upper_agent_name}_MONITOR_SV

class {agent_name}_monitor extends uvm_monitor;

  `uvm_component_utils({agent_name}_monitor)

  virtual {agent_name}_if vif;

  {agent_name}_config m_config;

  uvm_analysis_port #({agent_name}_tx) analysis_port;

  {agent_name}_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : {agent_name}_monitor 


function {agent_name}_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task {agent_name}_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = {agent_name}_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


`endif // {upper_agent_name}_MONITOR_SV
