module top_tb;

  timeunit      1ns;
  timeprecision 1ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import top_test_pkg::*;
  import top_pkg::top_config;

  // Configuration object for top-level environment
  top_config top_env_config;

  // Test harness
  top_th th();

  initial
  begin
    // Create and populate top-level configuration object
    top_env_config = new("top_env_config");
    if ( !top_env_config.randomize() )
      `uvm_fatal("top_tb", "Failed to randomize top-level configuration object" )

    top_env_config.m_ahb_m0_config.vif = th.ahb_m0_if;
    top_env_config.m_ahb_m1_config.vif = th.ahb_m1_if;
    top_env_config.m_ahb_m2_config.vif = th.ahb_m2_if;
    top_env_config.m_ahb_m3_config.vif = th.ahb_m3_if;
    top_env_config.m_ahb_s0_config.vif = th.ahb_s0_if;
    top_env_config.m_ahb_s1_config.vif = th.ahb_s1_if;
    top_env_config.m_ahb_s2_config.vif = th.ahb_s2_if;
    top_env_config.m_ahb_s3_config.vif = th.ahb_s3_if;

    uvm_config_db #(top_config)::set(null, "uvm_test_top", "config", top_env_config);
    uvm_config_db #(top_config)::set(null, "uvm_test_top.m_env", "config", top_env_config);

    run_test();
  end

endmodule
