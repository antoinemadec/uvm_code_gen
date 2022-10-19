`ifndef {upper_vip_name}_SEQ_LIB_SV
`define {upper_vip_name}_SEQ_LIB_SV

class {vip_name}_default_seq extends uvm_sequence #({vip_name}_tx);

  `uvm_object_utils({vip_name}_default_seq)

  {vip_name}_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : {vip_name}_default_seq


function {vip_name}_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task {vip_name}_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = {vip_name}_tx::type_id::create("req");
  start_item(req); 
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req); 

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // {upper_vip_name}_SEQ_LIB_SV
