`ifndef {upper_top}_SCOREBOARD
`define {upper_top}_SCOREBOARD

{sb_analysis_imp_macros}

class {top}_scoreboard extends uvm_scoreboard;
  `uvm_component_utils({top}_scoreboard)

{sb_analysis_imp_declaration}

  {top}_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #({top}_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get {top}_config")
{sb_analysis_imp_new}
  endfunction : new


{sb_writes}


endclass : {top}_scoreboard


`endif //  `ifndef {upper_top}_SCOREBOARD
