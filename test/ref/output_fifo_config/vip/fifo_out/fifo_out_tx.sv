`ifndef FIFO_OUT_SEQ_ITEM_SV
`define FIFO_OUT_SEQ_ITEM_SV

class fifo_out_tx extends uvm_sequence_item;

  `uvm_object_utils(fifo_out_tx)

  // transaction variables
  bit[15:0] data;


  extern function new(string name = "");
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

endclass : fifo_out_tx


function fifo_out_tx::new(string name = "");
  super.new(name);
endfunction : new


function void fifo_out_tx::do_copy(uvm_object rhs);
  fifo_out_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  data = rhs_.data;
endfunction : do_copy


function bit fifo_out_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  fifo_out_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("data", data, rhs_.data, $bits(data));
  return result;
endfunction : do_compare


function void fifo_out_tx::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void fifo_out_tx::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_field("data", data)
endfunction : do_record


function void fifo_out_tx::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(data)
endfunction : do_pack


function void fifo_out_tx::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(data)
endfunction : do_unpack


function string fifo_out_tx::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "data = 'h%0h  'd%0d\n"},
    get_full_name(),
    data, data);
  return s;
endfunction : convert2string


`endif // FIFO_OUT_SEQ_ITEM_SV
