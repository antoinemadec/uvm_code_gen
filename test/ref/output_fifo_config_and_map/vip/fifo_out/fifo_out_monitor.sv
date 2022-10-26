`ifndef FIFO_OUT_MONITOR_SV
`define FIFO_OUT_MONITOR_SV

class fifo_out_monitor extends uvm_monitor;

  `uvm_component_utils(fifo_out_monitor)

  virtual fifo_out_if vif;

  fifo_out_config m_config;

  uvm_analysis_port #(fifo_out_tx) analysis_port;

  fifo_out_tx m_trans;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_mon();

endclass : fifo_out_monitor


function fifo_out_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


task fifo_out_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  m_trans = fifo_out_tx::type_id::create("m_trans");
  do_mon();
endtask : run_phase


task fifo_out_monitor::do_mon();
  `uvm_fatal(get_type_name(), "TODO: fill do_mon()");
endtask : do_mon


`endif // FIFO_OUT_MONITOR_SV
