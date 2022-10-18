`ifndef {upper_agent_name}_DRIVER_SV
`define {upper_agent_name}_DRIVER_SV

class {agent_name}_driver extends uvm_driver #({agent_name}_tx);

  `uvm_component_utils({agent_name}_driver)

  virtual {agent_name}_if vif;

  {agent_name}_config m_config;

  extern function new(string name, uvm_component parent);

  extern task run_phase(uvm_phase phase);
  extern task do_drive();

endclass : {agent_name}_driver 


function {agent_name}_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


task {agent_name}_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), {{"req item\n",req.sprint}}, UVM_HIGH)
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase


`endif // {upper_agent_name}_DRIVER_SV
