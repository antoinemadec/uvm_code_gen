`ifndef AHB_SEQ_LIB_SV
`define AHB_SEQ_LIB_SV

class ahb_default_seq extends uvm_sequence #(ahb_tx);

  `uvm_object_utils(ahb_default_seq)

  ahb_config  m_config;

  extern function new(string name = "");
  extern task body();

endclass : ahb_default_seq


function ahb_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task ahb_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = ahb_tx::type_id::create("req");
  start_item(req);
  if ( !req.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize transaction")
  finish_item(req);

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // AHB_SEQ_LIB_SV
