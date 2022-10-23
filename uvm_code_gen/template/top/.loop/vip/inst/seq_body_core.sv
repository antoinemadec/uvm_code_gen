      if (m_{inst}_agent.m_config.is_active == UVM_ACTIVE)
      begin
        {vip}_default_seq seq;
        seq = {vip}_default_seq::type_id::create("seq");
        seq.set_item_context(this, m_{inst}_agent.m_sequencer);
        if ( !seq.randomize() )
          `uvm_error(get_type_name(), "Failed to randomize sequence")
        seq.m_config = m_{inst}_agent.m_config;
        seq.set_starting_phase( get_starting_phase() );
        seq.start(m_{inst}_agent.m_sequencer, this);
      end
