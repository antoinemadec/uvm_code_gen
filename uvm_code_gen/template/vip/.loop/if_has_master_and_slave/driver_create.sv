    if (m_config.is_master)
      m_driver = {vip}_master_driver::type_id::create("m_driver", this);
    else
      m_driver = {vip}_slave_driver::type_id::create("m_driver", this);
