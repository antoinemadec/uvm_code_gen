`ifndef {upper_vip}_COVERAGE_SV
`define {upper_vip}_COVERAGE_SV

class {vip}_coverage extends uvm_subscriber #({vip}_tx);

  `uvm_component_utils({vip}_coverage)

  {vip}_config m_config;
  {vip}_tx     m_item;
  bit m_is_covered;

  covergroup m_cov;
    option.per_instance = 1;
    // You may insert additional coverpoints here ...

{coverpoints}

  endgroup

  extern function new(string name, uvm_component parent);
  extern function void write(input {vip}_tx t);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

endclass : {vip}_coverage


function {vip}_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  m_is_covered = 0;
  m_cov = new();
endfunction : new


function void {vip}_coverage::write(input {vip}_tx t);
  if (m_config.coverage_enable)
  begin
    m_item = t;
    m_cov.sample();
    // Check coverage - could use m_cov.option.goal instead of 100 if your simulator supports it
    if (m_cov.get_inst_coverage() >= 100) m_is_covered = 1;
  end
endfunction : write


function void {vip}_coverage::build_phase(uvm_phase phase);
  if (!uvm_config_db #({vip}_config)::get(this, "", "config", m_config))
    `uvm_fatal(get_type_name(), "fifo_in config not found")
endfunction : build_phase


function void {vip}_coverage::report_phase(uvm_phase phase);
  if (m_config.coverage_enable)
    `uvm_info(get_type_name(), $sformatf("Coverage score = %3.1f%%", m_cov.get_inst_coverage()), UVM_MEDIUM)
  else
    `uvm_info(get_type_name(), "Coverage disabled for this agent", UVM_MEDIUM)
endfunction : report_phase


`endif // {upper_vip}_COVERAGE_SV
