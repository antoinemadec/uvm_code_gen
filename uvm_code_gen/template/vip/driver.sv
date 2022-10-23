`ifndef {upper_vip}_DRIVER_SV
`define {upper_vip}_DRIVER_SV

class {vip}_driver extends uvm_driver #({vip}_tx);

  `uvm_component_utils({vip}_driver)

  virtual {vip}_if vif;

  {vip}_config m_config;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_drive();

endclass : {vip}_driver


function {vip}_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task {vip}_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
    `uvm_info(get_type_name(), {{"req item\n",req.sprint}}, UVM_DEBUG)
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase


task {vip}_driver::do_drive();
  `uvm_fatal(get_type_name(), "TODO: fill do_drive()");
endtask : do_drive


`endif // {upper_vip}_DRIVER_SV
