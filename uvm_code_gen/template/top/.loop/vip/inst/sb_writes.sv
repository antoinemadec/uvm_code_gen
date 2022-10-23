  virtual function void write_from_{inst}(input {vip}_tx pkt);
    `uvm_info(get_type_name(), $sformatf("Received tx from {inst}: %s",
      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)
  endfunction: write_from_{inst}


