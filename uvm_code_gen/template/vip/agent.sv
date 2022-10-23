`ifndef {upper_vip}_AGENT_SV
`define {upper_vip}_AGENT_SV

class {vip}_agent extends uvm_agent;

  `uvm_component_utils({vip}_agent)

  uvm_analysis_port #({vip}_tx) analysis_port;

  {vip}_config       m_config;
  {vip}_sequencer_t  m_sequencer;
  {vip}_driver       m_driver;
  {vip}_monitor      m_monitor;

  local int m_is_active = -1;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function uvm_active_passive_enum get_is_active();

endclass : {vip}_agent


function  {vip}_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


function void {vip}_agent::build_phase(uvm_phase phase);

  if (!uvm_config_db #({vip}_config)::get(this, "", "config", m_config))
    `uvm_fatal(get_type_name(), "{vip} config not found")

  m_monitor = {vip}_monitor::type_id::create("m_monitor", this);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver = {vip}_driver::type_id::create("m_driver", this);
    m_sequencer = {vip}_sequencer_t::type_id::create("m_sequencer", this);
  end

endfunction : build_phase


function void {vip}_agent::connect_phase(uvm_phase phase);
  if (m_config.vif == null)
    `uvm_warning(get_type_name(), "{vip} virtual interface is not set!")

  m_monitor.vif = m_config.vif;
  m_monitor.m_config = m_config;
  m_monitor.analysis_port.connect(analysis_port);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_driver.vif = m_config.vif;
    m_driver.m_config = m_config;
  end

endfunction : connect_phase


function uvm_active_passive_enum {vip}_agent::get_is_active();
  if (m_is_active == -1)
  begin
    if (uvm_config_db#(uvm_bitstream_t)::get(this, "", "is_active", m_is_active))
    begin
      if (m_is_active != m_config.is_active)
        `uvm_warning(get_type_name(), "is_active field in config_db conflicts with config object")
    end
    else
      m_is_active = m_config.is_active;
  end
  return uvm_active_passive_enum'(m_is_active);
endfunction : get_is_active


`endif // {upper_vip}_AGENT_SV
