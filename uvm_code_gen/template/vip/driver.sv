`ifndef {upper_vip_name}_DRIVER_SV
`define {upper_vip_name}_DRIVER_SV

class {vip_name}_driver extends uvm_driver #({vip_name}_tx);

  `uvm_component_utils({vip_name}_driver)

  virtual {vip_name}_if vif;

  {vip_name}_config m_config;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_drive();

endclass : {vip_name}_driver


function {vip_name}_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task {vip_name}_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), {{"req item\n",req.sprint}}, UVM_HIGH)
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase


task {vip_name}_driver::do_drive();
  `uvm_fatal(get_type_name(), "TODO: fill do_drive()");
endtask : do_drive


`endif // {upper_vip_name}_DRIVER_SV
