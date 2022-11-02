`ifndef TOP_SCOREBOARD
`define TOP_SCOREBOARD

`uvm_analysis_imp_decl(_from_fifo_in0)
`uvm_analysis_imp_decl(_from_fifo_in1)
`uvm_analysis_imp_decl(_from_fifo_out0)
`uvm_analysis_imp_decl(_from_fifo_out1)

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp_from_fifo_in0 #(fifo_in_tx, top_scoreboard) fifo_in0_export;
  uvm_analysis_imp_from_fifo_in1 #(fifo_in_tx, top_scoreboard) fifo_in1_export;
  uvm_analysis_imp_from_fifo_out0 #(fifo_out_tx, top_scoreboard) fifo_out0_export;
  uvm_analysis_imp_from_fifo_out1 #(fifo_out_tx, top_scoreboard) fifo_out1_export;

  top_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get top_config")
    fifo_in0_export = new("fifo_in0_export", this);
    fifo_in1_export = new("fifo_in1_export", this);
    fifo_out0_export = new("fifo_out0_export", this);
    fifo_out1_export = new("fifo_out1_export", this);
  endfunction : new


  virtual function void write_from_fifo_in0(input fifo_in_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_in0: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_in0


  virtual function void write_from_fifo_in1(input fifo_in_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_in1: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_in1


  virtual function void write_from_fifo_out0(input fifo_out_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_out0: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_out0


  virtual function void write_from_fifo_out1(input fifo_out_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from fifo_out1: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_fifo_out1


endclass : top_scoreboard


`endif //  `ifndef TOP_SCOREBOARD
