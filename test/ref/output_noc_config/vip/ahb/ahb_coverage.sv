`ifndef AHB_COVERAGE_SV
`define AHB_COVERAGE_SV

class ahb_coverage extends uvm_subscriber #(ahb_tx);

  `uvm_component_utils(ahb_coverage)

  ahb_config m_config;
  ahb_tx     m_item;
  bit m_is_covered;

  covergroup m_cov;
    option.per_instance = 1;
    // You may insert additional coverpoints here ...

    cp_addr: coverpoint m_item.addr;
    cp_rwb: coverpoint m_item.rwb;
    cp_size: coverpoint m_item.size;
    cp_burst: coverpoint m_item.burst;
    cp_prot: coverpoint m_item.prot;
    cp_is_locked: coverpoint m_item.is_locked;
    cp_data: coverpoint m_item.data;

  endgroup

  extern function new(string name, uvm_component parent);
  extern function void write(input ahb_tx t);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

endclass : ahb_coverage


function ahb_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  m_is_covered = 0;
  m_cov = new();
endfunction : new


function void ahb_coverage::write(input ahb_tx t);
  if (m_config.coverage_enable)
  begin
    m_item = t;
    m_cov.sample();
    // Check coverage - could use m_cov.option.goal instead of 100 if your simulator supports it
    if (m_cov.get_inst_coverage() >= 100) m_is_covered = 1;
  end
endfunction : write


function void ahb_coverage::build_phase(uvm_phase phase);
  if (!uvm_config_db #(ahb_config)::get(this, "", "config", m_config))
    `uvm_fatal(get_type_name(), "fifo_in config not found")
endfunction : build_phase


function void ahb_coverage::report_phase(uvm_phase phase);
  if (m_config.coverage_enable)
    `uvm_info(get_type_name(), $sformatf("Coverage score = %3.1f%%", m_cov.get_inst_coverage()), UVM_MEDIUM)
  else
    `uvm_info(get_type_name(), "Coverage disabled for this agent", UVM_MEDIUM)
endfunction : report_phase


`endif // AHB_COVERAGE_SV
