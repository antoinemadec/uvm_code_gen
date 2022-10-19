`ifndef {upper_top_name}_TEST_SV
`define {upper_top_name}_TEST_SV

class {top_name}_test extends uvm_test;

  `uvm_component_utils({top_name}_test)

  {top_name}_env m_env;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);

endclass : {top_name}_test


function {top_name}_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void {top_name}_test::build_phase(uvm_phase phase);

  // you can modify any test-specific configuration object variables here,
  // or override the default sequence

  m_env = {top_name}_env::type_id::create("m_env", this);
endfunction : build_phase


`endif // {upper_top_name}_TEST_SV
