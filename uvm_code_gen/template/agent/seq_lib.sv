`ifndef {upper_agent_name}_SEQ_LIB_SV
`define {upper_agent_name}_SEQ_LIB_SV

class {agent_name}_default_seq extends uvm_sequence #({agent_name}_tx);

  `uvm_object_utils({agent_name}_default_seq)

  {agent_name}_config  m_config;

  extern function new(string name = "");
  extern task body();
endclass : {agent_name}_default_seq


function {agent_name}_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task {agent_name}_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = {agent_name}_tx::type_id::create("req");
  start_item(req); 
  if ( !req.randomize() )
    `uvm_error(get_type_name(), "Failed to randomize transaction")
  finish_item(req); 

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // {upper_agent_name}_SEQ_LIB_SV
