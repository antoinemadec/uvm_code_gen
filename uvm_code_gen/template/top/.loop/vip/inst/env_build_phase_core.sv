  m_{inst}_config = m_config.m_{inst}_config;
  uvm_config_db #({vip}_config)::set(this, "m_{inst}_agent", "config", m_{inst}_config);
  if (m_{inst}_config.is_active == UVM_ACTIVE )
    uvm_config_db #({vip}_config)::set(this, "m_{inst}_agent.m_sequencer", "config", m_{inst}_config);
  uvm_config_db #({vip}_config)::set(this, "m_{inst}_coverage", "config", m_{inst}_config);

  m_{inst}_agent = {vip}_agent::type_id::create("m_{inst}_agent", this);
  m_{inst}_coverage = {vip}_coverage::type_id::create("m_{inst}_coverage", this);

