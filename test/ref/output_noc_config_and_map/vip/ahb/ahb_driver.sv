`ifndef AHB_DRIVER_SV
`define AHB_DRIVER_SV

class ahb_driver extends uvm_driver #(ahb_tx);

  `uvm_component_utils(ahb_driver)

  virtual ahb_if vif;

  ahb_config m_config;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_drive();

endclass : ahb_driver


function ahb_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task ahb_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
    `uvm_info(get_type_name(), {"req item\n",req.sprint}, UVM_DEBUG)
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase


task ahb_driver::do_drive();
  `uvm_fatal(get_type_name(), "TODO: fill do_drive()");
endtask : do_drive


`endif // AHB_DRIVER_SV
