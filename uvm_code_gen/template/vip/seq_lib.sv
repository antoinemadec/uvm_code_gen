`ifndef {upper_vip}_SEQ_LIB_SV
`define {upper_vip}_SEQ_LIB_SV

class {vip}_default_seq extends uvm_sequence #({vip}_tx);

  `uvm_object_utils({vip}_default_seq)

  {vip}_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : {vip}_default_seq


function {vip}_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task {vip}_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = {vip}_tx::type_id::create("req");
  start_item(req);
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req);

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // {upper_vip}_SEQ_LIB_SV
