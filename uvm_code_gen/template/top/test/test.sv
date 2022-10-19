`ifndef TOP_TEST_SV
`define TOP_TEST_SV

class top_test extends uvm_test;

  `uvm_component_utils(top_test)

  top_env m_env;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);

endclass : top_test


function top_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_test::build_phase(uvm_phase phase);

  // You could modify any test-specific configuration object variables here



  m_env = top_env::type_id::create("m_env", this);

endfunction : build_phase


`endif // TOP_TEST_SV

