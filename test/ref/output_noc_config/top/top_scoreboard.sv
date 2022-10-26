`ifndef TOP_SCOREBOARD
`define TOP_SCOREBOARD

`uvm_analysis_imp_decl(_from_ahb)

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp_from_ahb #(ahb_tx, top_scoreboard) ahb_to_scoreboard;

  top_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get top_config")
    ahb_to_scoreboard = new("ahb_to_scoreboard", this);
  endfunction : new


  virtual function void write_from_ahb(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb


endclass : top_scoreboard


`endif //  `ifndef TOP_SCOREBOARD
