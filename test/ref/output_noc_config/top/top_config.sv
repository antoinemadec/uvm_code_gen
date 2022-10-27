`ifndef TOP_CONFIG_SV
`define TOP_CONFIG_SV

class top_config extends uvm_object;

  // do not register config class with the factory

  rand ahb_config m_ahb_config;

  extern function new(string name = "", bit coverage_enable = 0);

endclass : top_config


function top_config::new(string name = "", bit coverage_enable = 0);
  super.new(name);

  m_ahb_config = new("m_ahb_config");
  m_ahb_config.is_active = UVM_ACTIVE;
  m_ahb_config.checks_enable = 1;
  m_ahb_config.coverage_enable = coverage_enable;
endfunction : new


`endif // TOP_CONFIG_SV
