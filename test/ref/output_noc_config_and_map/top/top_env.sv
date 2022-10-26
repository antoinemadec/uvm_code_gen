`ifndef TOP_ENV_SV
`define TOP_ENV_SV

class top_env extends uvm_env;

  `uvm_component_utils(top_env)

  extern function new(string name, uvm_component parent);

  top_config     m_config;
  top_scoreboard m_scoreboard;

  ahb_config   m_ahb_m0_config;
  ahb_agent    m_ahb_m0_agent;
  ahb_coverage m_ahb_m0_coverage;

  ahb_config   m_ahb_m1_config;
  ahb_agent    m_ahb_m1_agent;
  ahb_coverage m_ahb_m1_coverage;

  ahb_config   m_ahb_m2_config;
  ahb_agent    m_ahb_m2_agent;
  ahb_coverage m_ahb_m2_coverage;

  ahb_config   m_ahb_m3_config;
  ahb_agent    m_ahb_m3_agent;
  ahb_coverage m_ahb_m3_coverage;

  ahb_config   m_ahb_s0_config;
  ahb_agent    m_ahb_s0_agent;
  ahb_coverage m_ahb_s0_coverage;

  ahb_config   m_ahb_s1_config;
  ahb_agent    m_ahb_s1_agent;
  ahb_coverage m_ahb_s1_coverage;

  ahb_config   m_ahb_s2_config;
  ahb_agent    m_ahb_s2_agent;
  ahb_coverage m_ahb_s2_coverage;

  ahb_config   m_ahb_s3_config;
  ahb_agent    m_ahb_s3_agent;
  ahb_coverage m_ahb_s3_coverage;

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

  m_ahb_m0_config = m_config.m_ahb_m0_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m0_agent", "config", m_ahb_m0_config);
  if (m_ahb_m0_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_m0_agent.m_sequencer", "config", m_ahb_m0_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m0_coverage", "config", m_ahb_m0_config);

  m_ahb_m0_agent = ahb_agent::type_id::create("m_ahb_m0_agent", this);
  m_ahb_m0_coverage = ahb_coverage::type_id::create("m_ahb_m0_coverage", this);

  m_ahb_m1_config = m_config.m_ahb_m1_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m1_agent", "config", m_ahb_m1_config);
  if (m_ahb_m1_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_m1_agent.m_sequencer", "config", m_ahb_m1_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m1_coverage", "config", m_ahb_m1_config);

  m_ahb_m1_agent = ahb_agent::type_id::create("m_ahb_m1_agent", this);
  m_ahb_m1_coverage = ahb_coverage::type_id::create("m_ahb_m1_coverage", this);

  m_ahb_m2_config = m_config.m_ahb_m2_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m2_agent", "config", m_ahb_m2_config);
  if (m_ahb_m2_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_m2_agent.m_sequencer", "config", m_ahb_m2_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m2_coverage", "config", m_ahb_m2_config);

  m_ahb_m2_agent = ahb_agent::type_id::create("m_ahb_m2_agent", this);
  m_ahb_m2_coverage = ahb_coverage::type_id::create("m_ahb_m2_coverage", this);

  m_ahb_m3_config = m_config.m_ahb_m3_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m3_agent", "config", m_ahb_m3_config);
  if (m_ahb_m3_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_m3_agent.m_sequencer", "config", m_ahb_m3_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_m3_coverage", "config", m_ahb_m3_config);

  m_ahb_m3_agent = ahb_agent::type_id::create("m_ahb_m3_agent", this);
  m_ahb_m3_coverage = ahb_coverage::type_id::create("m_ahb_m3_coverage", this);

  m_ahb_s0_config = m_config.m_ahb_s0_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s0_agent", "config", m_ahb_s0_config);
  if (m_ahb_s0_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_s0_agent.m_sequencer", "config", m_ahb_s0_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s0_coverage", "config", m_ahb_s0_config);

  m_ahb_s0_agent = ahb_agent::type_id::create("m_ahb_s0_agent", this);
  m_ahb_s0_coverage = ahb_coverage::type_id::create("m_ahb_s0_coverage", this);

  m_ahb_s1_config = m_config.m_ahb_s1_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s1_agent", "config", m_ahb_s1_config);
  if (m_ahb_s1_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_s1_agent.m_sequencer", "config", m_ahb_s1_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s1_coverage", "config", m_ahb_s1_config);

  m_ahb_s1_agent = ahb_agent::type_id::create("m_ahb_s1_agent", this);
  m_ahb_s1_coverage = ahb_coverage::type_id::create("m_ahb_s1_coverage", this);

  m_ahb_s2_config = m_config.m_ahb_s2_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s2_agent", "config", m_ahb_s2_config);
  if (m_ahb_s2_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_s2_agent.m_sequencer", "config", m_ahb_s2_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s2_coverage", "config", m_ahb_s2_config);

  m_ahb_s2_agent = ahb_agent::type_id::create("m_ahb_s2_agent", this);
  m_ahb_s2_coverage = ahb_coverage::type_id::create("m_ahb_s2_coverage", this);

  m_ahb_s3_config = m_config.m_ahb_s3_config;
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s3_agent", "config", m_ahb_s3_config);
  if (m_ahb_s3_config.is_active == UVM_ACTIVE )
    uvm_config_db #(ahb_config)::set(this, "m_ahb_s3_agent.m_sequencer", "config", m_ahb_s3_config);
  uvm_config_db #(ahb_config)::set(this, "m_ahb_s3_coverage", "config", m_ahb_s3_config);

  m_ahb_s3_agent = ahb_agent::type_id::create("m_ahb_s3_agent", this);
  m_ahb_s3_coverage = ahb_coverage::type_id::create("m_ahb_s3_coverage", this);
endfunction : build_phase


function void top_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)

  m_ahb_m0_agent.analysis_port.connect(m_ahb_m0_coverage.analysis_export);
  m_ahb_m0_agent.analysis_port.connect(m_scoreboard.ahb_m0_to_scoreboard);

  m_ahb_m1_agent.analysis_port.connect(m_ahb_m1_coverage.analysis_export);
  m_ahb_m1_agent.analysis_port.connect(m_scoreboard.ahb_m1_to_scoreboard);

  m_ahb_m2_agent.analysis_port.connect(m_ahb_m2_coverage.analysis_export);
  m_ahb_m2_agent.analysis_port.connect(m_scoreboard.ahb_m2_to_scoreboard);

  m_ahb_m3_agent.analysis_port.connect(m_ahb_m3_coverage.analysis_export);
  m_ahb_m3_agent.analysis_port.connect(m_scoreboard.ahb_m3_to_scoreboard);

  m_ahb_s0_agent.analysis_port.connect(m_ahb_s0_coverage.analysis_export);
  m_ahb_s0_agent.analysis_port.connect(m_scoreboard.ahb_s0_to_scoreboard);

  m_ahb_s1_agent.analysis_port.connect(m_ahb_s1_coverage.analysis_export);
  m_ahb_s1_agent.analysis_port.connect(m_scoreboard.ahb_s1_to_scoreboard);

  m_ahb_s2_agent.analysis_port.connect(m_ahb_s2_coverage.analysis_export);
  m_ahb_s2_agent.analysis_port.connect(m_scoreboard.ahb_s2_to_scoreboard);

  m_ahb_s3_agent.analysis_port.connect(m_ahb_s3_coverage.analysis_export);
  m_ahb_s3_agent.analysis_port.connect(m_scoreboard.ahb_s3_to_scoreboard);
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
  vseq.m_ahb_m0_agent = m_ahb_m0_agent;
  vseq.m_ahb_m1_agent = m_ahb_m1_agent;
  vseq.m_ahb_m2_agent = m_ahb_m2_agent;
  vseq.m_ahb_m3_agent = m_ahb_m3_agent;
  vseq.m_ahb_s0_agent = m_ahb_s0_agent;
  vseq.m_ahb_s1_agent = m_ahb_s1_agent;
  vseq.m_ahb_s2_agent = m_ahb_s2_agent;
  vseq.m_ahb_s3_agent = m_ahb_s3_agent;
  vseq.m_config = m_config;
  vseq.set_starting_phase(phase);
  vseq.start(null);
endtask : run_phase


`endif // TOP_ENV_SV
