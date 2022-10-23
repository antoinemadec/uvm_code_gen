  foreach ({var}[i])
    `uvm_record_field({{"{var}_",$sformatf("%0d",i)}}, {var}[i])
