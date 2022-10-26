`ifndef TOP_ENV_SV
`define TOP_ENV_SV

class top_env extends uvm_env;

  `uvm_component_utils(top_env)

  extern function new(string name, uvm_component parent);

  top_config     m_config;
  top_scoreboard m_scoreboard;

  fifo_in_config   m_fifo_in_config;
  fifo_in_agent    m_fifo_in_agent;
  fifo_in_coverage m_fifo_in_coverage;

  fifo_out_config   m_fifo_out_config;
  fifo_out_agent    m_fifo_out_agent;
  fifo_out_coverage m_fifo_out_coverage;

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

endclass : top_env


function top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void top_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)

  if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
    `uvm_fatal(get_type_name(), "Unable to get top_config")

  uvm_config_db #(top_config)::set(this, "m_scoreboard", "config", m_config);
  m_scoreboard = top_scoreboard::type_id::create("m_scoreboard",this);

  m_fifo_in_config = m_config.m_fifo_in_config;
  uvm_config_db #(fifo_in_config)::set(this, "m_fifo_in_agent", "config", m_fifo_in_config);
  if (m_fifo_in_config.is_active == UVM_ACTIVE )
    uvm_config_db #(fifo_in_config)::set(this, "m_fifo_in_agent.m_sequencer", "config", m_fifo_in_config);
  uvm_config_db #(fifo_in_config)::set(this, "m_fifo_in_coverage", "config", m_fifo_in_config);

  m_fifo_in_agent = fifo_in_agent::type_id::create("m_fifo_in_agent", this);
  m_fifo_in_coverage = fifo_in_coverage::type_id::create("m_fifo_in_coverage", this);

  m_fifo_out_config = m_config.m_fifo_out_config;
  uvm_config_db #(fifo_out_config)::set(this, "m_fifo_out_agent", "config", m_fifo_out_config);
  if (m_fifo_out_config.is_active == UVM_ACTIVE )
    uvm_config_db #(fifo_out_config)::set(this, "m_fifo_out_agent.m_sequencer", "config", m_fifo_out_config);
  uvm_config_db #(fifo_out_config)::set(this, "m_fifo_out_coverage", "config", m_fifo_out_config);

  m_fifo_out_agent = fifo_out_agent::type_id::create("m_fifo_out_agent", this);
  m_fifo_out_coverage = fifo_out_coverage::type_id::create("m_fifo_out_coverage", this);
endfunction : build_phase


function void top_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)

  m_fifo_in_agent.analysis_port.connect(m_fifo_in_coverage.analysis_export);
  m_fifo_in_agent.analysis_port.connect(m_scoreboard.fifo_in_to_scoreboard);

  m_fifo_out_agent.analysis_port.connect(m_fifo_out_coverage.analysis_export);
  m_fifo_out_agent.analysis_port.connect(m_scoreboard.fifo_out_to_scoreboard);
endfunction : connect_phase


function void top_env::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  `uvm_info(get_type_name(), "Information printed from top_env::end_of_elaboration_phase method", UVM_MEDIUM)
  `uvm_info(get_type_name(), $sformatf("Verbosity threshold is %d", get_report_verbosity_level()), UVM_MEDIUM)
  uvm_top.print_topology();
  factory.print();
endfunction : end_of_elaboration_phase


task top_env::run_phase(uvm_phase phase);
  top_default_seq vseq;
  vseq = top_default_seq::type_id::create("vseq");
  vseq.set_item_context(null, null);
  if ( !vseq.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize virtual sequence")
  vseq.m_fifo_in_agent = m_fifo_in_agent;
  vseq.m_fifo_out_agent = m_fifo_out_agent;
  vseq.m_config = m_config;
  vseq.set_starting_phase(phase);
  vseq.start(null);
endtask : run_phase


`endif // TOP_ENV_SV
