`ifndef TOP_SCOREBOARD
`define TOP_SCOREBOARD

`uvm_analysis_imp_decl(_from_ahb_m0)
`uvm_analysis_imp_decl(_from_ahb_m1)
`uvm_analysis_imp_decl(_from_ahb_m2)
`uvm_analysis_imp_decl(_from_ahb_m3)
`uvm_analysis_imp_decl(_from_ahb_s0)
`uvm_analysis_imp_decl(_from_ahb_s1)
`uvm_analysis_imp_decl(_from_ahb_s2)
`uvm_analysis_imp_decl(_from_ahb_s3)

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp_from_ahb_m0 #(ahb_tx, top_scoreboard) ahb_m0_export;
  uvm_analysis_imp_from_ahb_m1 #(ahb_tx, top_scoreboard) ahb_m1_export;
  uvm_analysis_imp_from_ahb_m2 #(ahb_tx, top_scoreboard) ahb_m2_export;
  uvm_analysis_imp_from_ahb_m3 #(ahb_tx, top_scoreboard) ahb_m3_export;
  uvm_analysis_imp_from_ahb_s0 #(ahb_tx, top_scoreboard) ahb_s0_export;
  uvm_analysis_imp_from_ahb_s1 #(ahb_tx, top_scoreboard) ahb_s1_export;
  uvm_analysis_imp_from_ahb_s2 #(ahb_tx, top_scoreboard) ahb_s2_export;
  uvm_analysis_imp_from_ahb_s3 #(ahb_tx, top_scoreboard) ahb_s3_export;

  top_config m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    if (!uvm_config_db #(top_config)::get(this, "", "config", m_config))
      `uvm_fatal(get_type_name(), "Unable to get top_config")
    ahb_m0_export = new("ahb_m0_export", this);
    ahb_m1_export = new("ahb_m1_export", this);
    ahb_m2_export = new("ahb_m2_export", this);
    ahb_m3_export = new("ahb_m3_export", this);
    ahb_s0_export = new("ahb_s0_export", this);
    ahb_s1_export = new("ahb_s1_export", this);
    ahb_s2_export = new("ahb_s2_export", this);
    ahb_s3_export = new("ahb_s3_export", this);
  endfunction : new


  virtual function void write_from_ahb_m0(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_m0: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_m0


  virtual function void write_from_ahb_m1(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_m1: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_m1


  virtual function void write_from_ahb_m2(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_m2: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_m2


  virtual function void write_from_ahb_m3(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_m3: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_m3


  virtual function void write_from_ahb_s0(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_s0: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_s0


  virtual function void write_from_ahb_s1(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_s1: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_s1


  virtual function void write_from_ahb_s2(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_s2: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_s2


  virtual function void write_from_ahb_s3(input ahb_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from ahb_s3: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_ahb_s3


endclass : top_scoreboard


`endif //  `ifndef TOP_SCOREBOARD
