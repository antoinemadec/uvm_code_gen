`ifndef FIFO_IN_AGENT_SV
`define FIFO_IN_AGENT_SV

class fifo_in_agent extends uvm_agent;

  `uvm_component_utils(fifo_in_agent)

  uvm_analysis_port #(fifo_in_tx) analysis_port;

  fifo_in_config       m_config;
  fifo_in_sequencer_t  m_sequencer;
  fifo_in_driver       m_driver;
  fifo_in_monitor      m_monitor;

  local int m_is_active = -1;

  extern function new(string name, uvm_component parent);

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function uvm_active_passive_enum get_is_active();

endclass : fifo_in_agent


function  fifo_in_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


function void fifo_in_agent::build_phase(uvm_phase phase);

  if (!uvm_config_db #(fifo_in_config)::get(this, "", "config", m_config))
    `uvm_fatal(get_type_name(), "fifo_in config not found")

  m_monitor = fifo_in_monitor::type_id::create("m_monitor", this);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver = fifo_in_driver::type_id::create("m_driver", this);
    m_sequencer = fifo_in_sequencer_t::type_id::create("m_sequencer", this);
  end

endfunction : build_phase


function void fifo_in_agent::connect_phase(uvm_phase phase);
  if (m_config.vif == null)
    `uvm_warning(get_type_name(), "fifo_in virtual interface is not set!")

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


function uvm_active_passive_enum fifo_in_agent::get_is_active();
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


`endif // FIFO_IN_AGENT_SV
