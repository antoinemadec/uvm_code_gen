`ifndef FIFO_IN_SEQ_LIB_SV
`define FIFO_IN_SEQ_LIB_SV

class fifo_in_default_seq extends uvm_sequence #(fifo_in_tx);

  `uvm_object_utils(fifo_in_default_seq)

  fifo_in_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : fifo_in_default_seq


function fifo_in_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task fifo_in_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = fifo_in_tx::type_id::create("req");
  start_item(req);
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req);

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // FIFO_IN_SEQ_LIB_SV
