`ifndef TOP_SCOREBOARD
`define TOP_SCOREBOARD

`uvm_analysis_imp_decl(_from_fifo_in)
`uvm_analysis_imp_decl(_from_fifo_out)

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp_from_fifo_in #(fifo_in_tx, top_scoreboard) fifo_in_export;
  uvm_analysis_imp_from_fifo_out #(fifo_out_tx, top_scoreboard) fifo_out_export;

  top_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get top_config")
    fifo_in_export = new("fifo_in_export", this);
    fifo_out_export = new("fifo_out_export", this);
  endfunction : new


  virtual function void write_from_fifo_in(input fifo_in_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_in: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_in


  virtual function void write_from_fifo_out(input fifo_out_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_out: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_out


endclass : top_scoreboard


`endif //  `ifndef TOP_SCOREBOARD
