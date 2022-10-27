`ifndef TOP_CONFIG_SV
`define TOP_CONFIG_SV

class top_config extends uvm_object;

  // do not register config class with the factory

  rand fifo_in_config m_fifo_in0_config;
  rand fifo_in_config m_fifo_in1_config;
  rand fifo_out_config m_fifo_out0_config;
  rand fifo_out_config m_fifo_out1_config;

  extern function new(string name = "", bit coverage_enable = 0);

endclass : top_config


function top_config::new(string name = "", bit coverage_enable = 0);
  super.new(name);

  m_fifo_in0_config = new("m_fifo_in0_config");
  m_fifo_in0_config.is_active = UVM_ACTIVE;
  m_fifo_in0_config.checks_enable = 1;
  m_fifo_in0_config.coverage_enable = coverage_enable;

  m_fifo_in1_config = new("m_fifo_in1_config");
  m_fifo_in1_config.is_active = UVM_ACTIVE;
  m_fifo_in1_config.checks_enable = 1;
  m_fifo_in1_config.coverage_enable = coverage_enable;

  m_fifo_out0_config = new("m_fifo_out0_config");
  m_fifo_out0_config.is_active = UVM_ACTIVE;
  m_fifo_out0_config.checks_enable = 1;
  m_fifo_out0_config.coverage_enable = coverage_enable;

  m_fifo_out1_config = new("m_fifo_out1_config");
  m_fifo_out1_config.is_active = UVM_ACTIVE;
  m_fifo_out1_config.checks_enable = 1;
  m_fifo_out1_config.coverage_enable = coverage_enable;
endfunction : new


`endif // TOP_CONFIG_SV
