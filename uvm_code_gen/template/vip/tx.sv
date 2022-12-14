`ifndef {upper_vip}_SEQ_ITEM_SV
`define {upper_vip}_SEQ_ITEM_SV

class {vip}_tx extends uvm_sequence_item;

  `uvm_object_utils({vip}_tx)

  // transaction variables
{trans_vars}


  extern function new(string name = "");
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

endclass : {vip}_tx


function {vip}_tx::new(string name = "");
  super.new(name);
endfunction : new


function void {vip}_tx::do_copy(uvm_object rhs);
  {vip}_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
{tx_do_copy}
endfunction : do_copy


function bit {vip}_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  {vip}_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
{tx_do_compare}
  return result;
endfunction : do_compare


function void {vip}_tx::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void {vip}_tx::do_record(uvm_recorder recorder);
  super.do_record(recorder);
{tx_do_record}
endfunction : do_record


function void {vip}_tx::do_pack(uvm_packer packer);
  super.do_pack(packer);
{tx_do_pack}
endfunction : do_pack


function void {vip}_tx::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
{tx_do_unpack}
endfunction : do_unpack


function string {vip}_tx::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {{"%s\n",
{tx_convert2string_str}}},
    get_full_name(),
{tx_convert2string_val});
  return s;
endfunction : convert2string


`endif // {upper_vip}_SEQ_ITEM_SV
