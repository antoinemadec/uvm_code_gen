`ifndef {upper_top_name}_SCOREBOARD
`define {upper_top_name}_SCOREBOARD

{sb_analysis_imp_macros}

class {top_name}_scoreboard extends uvm_scoreboard;
  `uvm_component_utils({top_name}_scoreboard)

{sb_analysis_imp_declaration}

  {top_name}_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #({top_name}_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get {top_name}_config")
{sb_analysis_imp_new}
  endfunction : new


{sb_writes}


endclass : {top_name}_scoreboard


`endif //  `ifndef {upper_top_name}_SCOREBOARD
