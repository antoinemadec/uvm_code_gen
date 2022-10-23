  clocking cb_drv @(posedge {clock});
{clocking_block_ports}
  endclocking : cb_drv

  clocking cb_mon @(posedge {clock});
{clocking_block_ports}
  endclocking : cb_mon
