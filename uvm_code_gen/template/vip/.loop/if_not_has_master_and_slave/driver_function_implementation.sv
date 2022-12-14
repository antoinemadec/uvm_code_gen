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
