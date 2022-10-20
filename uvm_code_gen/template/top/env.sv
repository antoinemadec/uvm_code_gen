`ifndef {upper_top_name}_ENV_SV
`define {upper_top_name}_ENV_SV

class {top_name}_env extends uvm_env;

  `uvm_component_utils({top_name}_env)

  extern function new(string name, uvm_component parent);

  {top_name}_config     m_config;
  {top_name}_scoreboard m_scoreboard;

{vip_declarations}

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

endclass : {top_name}_env 


function {top_name}_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


function void {top_name}_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)

  if (!uvm_config_db #({top_name}_config)::get(this, "", "config", m_config)) 
    `uvm_fatal(get_type_name(), "Unable to get {top_name}_config")

  uvm_config_db #({top_name}_config)::set(this, "m_scoreboard", "config", m_config);
  m_scoreboard = {top_name}_scoreboard::type_id::create("m_scoreboard",this);

{env_build_phase_core}
endfunction : build_phase


function void {top_name}_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)

{env_connect_phase_core}
endfunction : connect_phase


function void {top_name}_env::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  `uvm_info(get_type_name(), "Information printed from {top_name}_env::end_of_elaboration_phase method", UVM_MEDIUM)
  `uvm_info(get_type_name(), $sformatf("Verbosity threshold is %d", get_report_verbosity_level()), UVM_MEDIUM)
  uvm_top.print_topology();
  factory.print();
endfunction : end_of_elaboration_phase


task {top_name}_env::run_phase(uvm_phase phase);
  {top_name}_default_seq vseq;
  vseq = {top_name}_default_seq::type_id::create("vseq");
  vseq.set_item_context(null, null);
  if ( !vseq.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize virtual sequence")
{env_run_phase_core}
  vseq.m_config = m_config;        
  vseq.set_starting_phase(phase);
  vseq.start(null);
endtask : run_phase


`endif // {upper_top_name}_ENV_SV
