module {top_name}_tb;

  timeunit      1ns;
  timeprecision 1ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import {top_name}_test_pkg::*;
  import {top_name}_pkg::{top_name}_config;

  // Configuration object for {top_name}-level environment
  {top_name}_config {top_name}_env_config;

  // Test harness
  {top_name}_th th();

  initial
  begin
    // Create and populate {top_name}-level configuration object
    {top_name}_env_config = new("{top_name}_env_config");
    if ( !{top_name}_env_config.randomize() )
      `uvm_fatal("{top_name}_tb", "Failed to randomize top-level configuration object" )

    {top_name}_env_config.m_fifo_in_config.vif  = th.fifo_in_if;
    {top_name}_env_config.m_fifo_out_config.vif = th.fifo_out_if;

    uvm_config_db #({top_name}_config)::set(null, "uvm_test_top", "config", {top_name}_env_config);
    uvm_config_db #({top_name}_config)::set(null, "uvm_test_top.m_env", "config", {top_name}_env_config);

    run_test();
  end

endmodule
