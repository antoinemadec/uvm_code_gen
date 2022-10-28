`ifndef TOP_SCOREBOARD
`define TOP_SCOREBOARD

`uvm_analysis_imp_decl(_from_handshake_master)
`uvm_analysis_imp_decl(_from_handshake_slave)

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp_from_handshake_master #(handshake_tx, top_scoreboard) handshake_master_to_scoreboard;
  uvm_analysis_imp_from_handshake_slave #(handshake_tx, top_scoreboard) handshake_slave_to_scoreboard;

  top_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get top_config")
    handshake_master_to_scoreboard = new("handshake_master_to_scoreboard", this);
    handshake_slave_to_scoreboard = new("handshake_slave_to_scoreboard", this);
  endfunction : new


  virtual function void write_from_handshake_master(input handshake_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from handshake_master: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_handshake_master


  virtual function void write_from_handshake_slave(input handshake_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from handshake_slave: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_handshake_slave


endclass : top_scoreboard


`endif //  `ifndef TOP_SCOREBOARD
