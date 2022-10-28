`ifndef HANDSHAKE_SEQ_LIB_SV
`define HANDSHAKE_SEQ_LIB_SV

class handshake_default_seq extends uvm_sequence #(handshake_tx);

  `uvm_object_utils(handshake_default_seq)

  handshake_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : handshake_default_seq


function handshake_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task handshake_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = handshake_tx::type_id::create("req");
  start_item(req);
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req);

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // HANDSHAKE_SEQ_LIB_SV
