`ifndef AHB_SEQ_ITEM_SV
`define AHB_SEQ_ITEM_SV

class ahb_tx extends uvm_sequence_item;

  `uvm_object_utils(ahb_tx)

  // transaction variables
  rand bit[31:0] addr;
  rand bit rwb;
  rand bit[2:0] size;
  rand burst_t burst;
  rand bit[6:0] prot;
  rand bit is_locked;
  rand bit[31:0] data[$];


  extern function new(string name = "");
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

endclass : ahb_tx


function ahb_tx::new(string name = "");
  super.new(name);
endfunction : new


function void ahb_tx::do_copy(uvm_object rhs);
  ahb_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  addr = rhs_.addr;
  rwb = rhs_.rwb;
  size = rhs_.size;
  burst = rhs_.burst;
  prot = rhs_.prot;
  is_locked = rhs_.is_locked;
  data = rhs_.data;
endfunction : do_copy


function bit ahb_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  ahb_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("addr", addr, rhs_.addr, $bits(addr));
  result &= comparer.compare_field("rwb", rwb, rhs_.rwb, $bits(rwb));
  result &= comparer.compare_field("size", size, rhs_.size, $bits(size));
  result &= comparer.compare_field("burst", burst, rhs_.burst, $bits(burst));
  result &= comparer.compare_field("prot", prot, rhs_.prot, $bits(prot));
  result &= comparer.compare_field("is_locked", is_locked, rhs_.is_locked, $bits(is_locked));
  foreach (data[i])
    result &= comparer.compare_field("data", data[i], rhs_.data[i], $bits(data[i]));
  return result;
endfunction : do_compare


function void ahb_tx::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void ahb_tx::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_field("addr", addr)
  `uvm_record_field("rwb", rwb)
  `uvm_record_field("size", size)
  `uvm_record_field("burst", burst)
  `uvm_record_field("prot", prot)
  `uvm_record_field("is_locked", is_locked)
  foreach (data[i])
    `uvm_record_field({"data_",$sformatf("%0d",i)}, data[i])
endfunction : do_record


function void ahb_tx::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(addr)
  `uvm_pack_int(rwb)
  `uvm_pack_int(size)
  `uvm_pack_int(burst)
  `uvm_pack_int(prot)
  `uvm_pack_int(is_locked)
  `uvm_pack_sarray(data)
endfunction : do_pack


function void ahb_tx::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(addr)
  `uvm_unpack_int(rwb)
  `uvm_unpack_int(size)
  `uvm_unpack_int(burst)
  `uvm_unpack_int(prot)
  `uvm_unpack_int(is_locked)
  `uvm_unpack_sarray(data)
endfunction : do_unpack


function string ahb_tx::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "addr = 'h%0h  'd%0d\n",
    "rwb = 'h%0h  'd%0d\n",
    "size = 'h%0h  'd%0d\n",
    "burst = 'h%0h  'd%0d\n",
    "prot = 'h%0h  'd%0d\n",
    "is_locked = 'h%0h  'd%0d\n",
    "data = %p\n"},
    get_full_name(),
    addr, addr,
    rwb, rwb,
    size, size,
    burst, burst,
    prot, prot,
    is_locked, is_locked,
    data);
  return s;
endfunction : convert2string


`endif // AHB_SEQ_ITEM_SV
