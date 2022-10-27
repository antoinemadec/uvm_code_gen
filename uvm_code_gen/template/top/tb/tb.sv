module {top}_tb;

  timeunit      1ns;
  timeprecision 1ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import {top}_test_pkg::*;
  import {top}_pkg::{top}_config;

  {top}_config {top}_env_config;

  // test harness
  {top}_th th();

  initial
  begin
    bit coverage_enable;
    coverage_enable = $test$plusargs("coverage_enable") ? 1:0;

    {top}_env_config = new("{top}_env_config", coverage_enable);
    if ( !{top}_env_config.randomize() )
      `uvm_fatal("{top}_tb", "Failed to randomize top-level configuration object" )

{top_env_conf_vif}

    uvm_config_db #({top}_config)::set(null, "uvm_test_top", "config", {top}_env_config);
    uvm_config_db #({top}_config)::set(null, "uvm_test_top.m_env", "config", {top}_env_config);

    run_test();
  end

endmodule
