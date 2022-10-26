`ifndef FIFO_OUT_SEQ_LIB_SV
`define FIFO_OUT_SEQ_LIB_SV

class fifo_out_default_seq extends uvm_sequence #(fifo_out_tx);

  `uvm_object_utils(fifo_out_default_seq)

  fifo_out_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : fifo_out_default_seq


function fifo_out_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task fifo_out_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = fifo_out_tx::type_id::create("req");
  start_item(req);
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req);

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // FIFO_OUT_SEQ_LIB_SV
