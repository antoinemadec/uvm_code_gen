`ifndef {upper_top}_TEST_SV
`define {upper_top}_TEST_SV

class {top}_test extends uvm_test;

  `uvm_component_utils({top}_test)

  {top}_env m_env;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);

endclass : {top}_test


function {top}_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void {top}_test::build_phase(uvm_phase phase);

  // you can modify any test-specific configuration object variables here,
  // or override the default sequence

  m_env = {top}_env::type_id::create("m_env", this);
endfunction : build_phase


`endif // {upper_top}_TEST_SV
