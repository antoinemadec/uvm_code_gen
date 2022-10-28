`ifndef HANDSHAKE_SEQ_ITEM_SV
`define HANDSHAKE_SEQ_ITEM_SV

class handshake_tx extends uvm_sequence_item;

  `uvm_object_utils(handshake_tx)

  // transaction variables
  rand bit[31:0] data;


  extern function new(string name = "");
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

endclass : handshake_tx


function handshake_tx::new(string name = "");
  super.new(name);
endfunction : new


function void handshake_tx::do_copy(uvm_object rhs);
  handshake_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  data = rhs_.data;
endfunction : do_copy


function bit handshake_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  handshake_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("data", data, rhs_.data, $bits(data));
  return result;
endfunction : do_compare


function void handshake_tx::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void handshake_tx::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_field("data", data)
endfunction : do_record


function void handshake_tx::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(data)
endfunction : do_pack


function void handshake_tx::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(data)
endfunction : do_unpack


function string handshake_tx::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "data = 'h%0h  'd%0d\n"},
    get_full_name(),
    data, data);
  return s;
endfunction : convert2string


`endif // HANDSHAKE_SEQ_ITEM_SV
