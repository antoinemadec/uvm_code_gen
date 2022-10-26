`ifndef TOP_CONFIG_SV
`define TOP_CONFIG_SV

class top_config extends uvm_object;

  // do not register config class with the factory

  rand ahb_config m_ahb_m0_config;
  rand ahb_config m_ahb_m1_config;
  rand ahb_config m_ahb_m2_config;
  rand ahb_config m_ahb_m3_config;
  rand ahb_config m_ahb_s0_config;
  rand ahb_config m_ahb_s1_config;
  rand ahb_config m_ahb_s2_config;
  rand ahb_config m_ahb_s3_config;

  extern function new(string name = "");

endclass : top_config


function top_config::new(string name = "");
  super.new(name);

  m_ahb_m0_config = new("m_ahb_m0_config");
  m_ahb_m0_config.is_active = UVM_ACTIVE;
  m_ahb_m0_config.checks_enable = 1;
  m_ahb_m0_config.coverage_enable = 1;

  m_ahb_m1_config = new("m_ahb_m1_config");
  m_ahb_m1_config.is_active = UVM_ACTIVE;
  m_ahb_m1_config.checks_enable = 1;
  m_ahb_m1_config.coverage_enable = 1;

  m_ahb_m2_config = new("m_ahb_m2_config");
  m_ahb_m2_config.is_active = UVM_ACTIVE;
  m_ahb_m2_config.checks_enable = 1;
  m_ahb_m2_config.coverage_enable = 1;

  m_ahb_m3_config = new("m_ahb_m3_config");
  m_ahb_m3_config.is_active = UVM_ACTIVE;
  m_ahb_m3_config.checks_enable = 1;
  m_ahb_m3_config.coverage_enable = 1;

  m_ahb_s0_config = new("m_ahb_s0_config");
  m_ahb_s0_config.is_active = UVM_ACTIVE;
  m_ahb_s0_config.checks_enable = 1;
  m_ahb_s0_config.coverage_enable = 1;

  m_ahb_s1_config = new("m_ahb_s1_config");
  m_ahb_s1_config.is_active = UVM_ACTIVE;
  m_ahb_s1_config.checks_enable = 1;
  m_ahb_s1_config.coverage_enable = 1;

  m_ahb_s2_config = new("m_ahb_s2_config");
  m_ahb_s2_config.is_active = UVM_ACTIVE;
  m_ahb_s2_config.checks_enable = 1;
  m_ahb_s2_config.coverage_enable = 1;

  m_ahb_s3_config = new("m_ahb_s3_config");
  m_ahb_s3_config.is_active = UVM_ACTIVE;
  m_ahb_s3_config.checks_enable = 1;
  m_ahb_s3_config.coverage_enable = 1;
endfunction : new


`endif // TOP_CONFIG_SV
