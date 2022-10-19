from pathlib import Path

from .utils import *


class TransactionVariable(object):
    def __init__(self, definition: str):
        self.definition = definition
        sv_code = SvCode(definition)
        self.signal_name = sv_code.get_signal_name()
        self.is_unpacked_array = sv_code.get_is_unpacked_array()


class InterfacePort(object):
    def __init__(self, definition: str, is_clock=False):
        self.definition = definition
        self.signal_name = SvCode(definition).get_signal_name()
        self.is_clock = is_clock


class UvmVip(object):
    """parse template and create UVM Vip"""

    def __init__(self,
                 description_file: str,
                 output_dir: str = "./output",
                 template_dir: str = ""):
        # description
        self.vip_name = ""
        self.if_ports: list[InterfacePort] = []
        self.trans_vars: list[TransactionVariable] = []
        self.parse_description_file(description_file)
        # output
        self.vip_dir = Path(output_dir) / self.vip_name
        self.template_dir = get_template_dir(template_dir)

    def parse_description_file(self, description_file: str):
        valid_keywords = ("vip_name", "trans_var", "if_port", "if_clock")
        if_clock = ""
        with open(description_file, 'r') as f:
            for ln, line_str in enumerate(f):
                line_str = line_str.strip()
                line = line_str.split()
                # check for comments or misformatted file
                if not line or line[0][0] == "#":
                    continue
                elif len(line) < 3:
                    print_file_error("too few arguments",
                                     description_file, ln+1, line_str)
                    exit(1)
                elif line[0] not in valid_keywords:
                    print_file_error(
                        f"invalid keyword \"{line[0]}\"", description_file, ln+1, line_str)
                    exit(1)
                elif line[1] != "=":
                    print_file_error(f"missing \"=\"",
                                     description_file, ln+1, line_str)
                    exit(1)
                # parse valid keywords
                keyword = line[0]
                args = line[2:]
                args_str = " ".join(args)
                if keyword == "vip_name":
                    if len(args) != 1:
                        print_file_error(
                            f"vip_name expect only 1 value", description_file, ln+1, line_str)
                        exit(1)
                    self.vip_name = args[0]
                elif keyword == "trans_var":
                    self.trans_vars.append(TransactionVariable(args_str))
                elif keyword == "if_port":
                    self.if_ports.append(InterfacePort(args_str))
                elif keyword == "if_clock":
                    if_clock = args[0]

        # post processing and final checks
        for p in self.if_ports:
            if p.signal_name == if_clock:
                p.is_clock = True
        if not self.vip_name:
            print_error(f"no vip_name found in {description_file}")
            exit(1)

    def fill_template(self, template_name: str, **fmt_values):
        template_path = self.template_dir / f"vip/{template_name}.sv"
        output_path = self.vip_dir / f"{self.vip_name}_{template_name}.sv"
        fill_template(output_path, template_path, **fmt_values)

    def get_coverpoints(self) -> str:
        coverpoints = []
        for var in self.trans_vars:
            var_name = var.signal_name
            coverpoints.append(
                f"    cp_{var_name}: coverpoint m_item.{var_name};")
        return "\n".join(coverpoints)

    def get_ports(self) -> str:
        ports = [f"  {p.definition}" for p in self.if_ports]
        return "\n".join(ports)

    def get_tx_fmt_values(self) -> dict[str, str]:
        trans_vars = []
        tx_do_copy = []
        tx_do_compare = []
        tx_do_record = []
        tx_do_pack = []
        tx_do_unpack = []
        tx_convert2string = []
        tx_convert2string_fmt_values = []
        for var in self.trans_vars:
            name = var.signal_name
            definition = var.definition
            is_array = var.is_unpacked_array
            trans_vars.append(f"  {definition}")
            tx_do_copy.append(f"  {name} = rhs_.{name};")
            if is_array:
                foreach_str = f"  foreach ({name}[i])\n"
                tx_do_compare.append(foreach_str +
                                     f"    result &= comparer.compare_field(\"{name}\", {name}[i], rhs_.{name}[i], $bits({name}[i]));")
                tx_do_record.append(foreach_str +
                                    f"    `uvm_record_field({{\"{name}_\",$sformatf(\"%0d\",i)}}, {name}[i])")
                pack_str = f"  `uvm_pack_sarray({name})"
                tx_convert2string.append(f"\"{name} = %p\\n\"")
                tx_convert2string_fmt_values.append(f"{name}")
            else:
                tx_do_compare.append(
                    f"  result &= comparer.compare_field(\"{name}\", {name}, rhs_.{name}, $bits({name}));")
                tx_do_record.append(f"  `uvm_record_field(\"{name}\", {name})")
                pack_str = f"  `uvm_pack_int({name})"
                tx_convert2string.append(f"\"{name} = 'h%0h  'd%0d\\n\"")
                tx_convert2string_fmt_values.append(f"{name}")
                tx_convert2string_fmt_values.append(f"{name}")
            tx_do_pack.append(pack_str)
            tx_do_unpack.append(pack_str.replace("uvm_pack_", "uvm_unpack_"))
        final_convert2string_str = f"  $sformat(s, {{\"%s\\n\",\n    " + \
            ",\n    ".join(tx_convert2string) + \
            f"}},\n    get_full_name(), {', '.join(tx_convert2string_fmt_values)});"
        d = {
            "trans_vars": "\n".join(trans_vars),
            "tx_do_copy": "\n".join(tx_do_copy),
            "tx_do_compare": "\n".join(tx_do_compare),
            "tx_do_record": "\n".join(tx_do_record),
            "tx_do_pack": "\n".join(tx_do_pack),
            "tx_do_unpack": "\n".join(tx_do_unpack),
            "tx_convert2string": final_convert2string_str
        }
        return d

    def write_files(self):
        fmt_values = {
            "vip_name": self.vip_name,
            "upper_vip_name": self.vip_name.upper(),
            "coverpoints": self.get_coverpoints(),
            "ports": self.get_ports()
        }
        fmt_values = {**fmt_values, **self.get_tx_fmt_values()}
        self.fill_template("agent", **fmt_values)
        self.fill_template("config", **fmt_values)
        self.fill_template("coverage", **fmt_values)
        self.fill_template("driver", **fmt_values)
        self.fill_template("if", **fmt_values)
        self.fill_template("monitor", **fmt_values)
        self.fill_template("pkg", **fmt_values)
        self.fill_template("seq_lib", **fmt_values)
        self.fill_template("sequencer", **fmt_values)
        self.fill_template("tx", **fmt_values)
