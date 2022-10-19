`ifndef {upper_top_name}_SEQ_LIB_SV
`define {upper_top_name}_SEQ_LIB_SV

class {top_name}_default_seq extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils({top_name}_default_seq)

  {top_name}_config m_config;
  
{agent_declarations}

  int m_seq_count = 1;

  extern function new(string name = "");
  extern task body();
  extern task pre_start();
  extern task post_start();

endclass : {top_name}_default_seq


function {top_name}_default_seq::new(string name = "");
  super.new(name);
endfunction : new


task {top_name}_default_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)


  repeat (m_seq_count)
  begin
    fork
{seq_body_core}
    join
  end

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body


task {top_name}_default_seq::pre_start();
  uvm_phase phase = get_starting_phase();
  if (phase != null)
    phase.raise_objection(this);
endtask: pre_start


task {top_name}_default_seq::post_start();
  uvm_phase phase = get_starting_phase();
  if (phase != null) 
    phase.drop_objection(this);
endtask: post_start


`endif // {upper_top_name}_SEQ_LIB_SV
