from pathlib import Path

from .utils import *


class TransactionVariable(object):
    def __init__(self, definition: str):
        self.definition = definition
        sv_code = SvCode(definition)
        self.signal_name = sv_code.get_signal_name()
        self.is_unpacked_array = sv_code.get_is_unpacked_array()


class InterfacePort(object):
    def __init__(self, definition: str):
        self.definition = definition
        self.signal_name = SvCode(definition).get_signal_name()


class UvmVip(object):
    """parse template and create UVM Vip"""

    def __init__(self,
                 description_file: str = "",
                 output_dir: str = "./output",
                 template_dir: str = ""):
        # description
        self.vip_name = ""
        self.has_master_and_slave = False
        self.if_ports: list[InterfacePort] = []
        self.if_clock: InterfacePort | None = None
        self.trans_vars: list[TransactionVariable] = []
        if description_file:
            self.parse_description_file(description_file)
        # output
        self.vip_dir = Path(output_dir) / self.vip_name
        self.template_dir = get_template_dir(template_dir)

    def parse_description_file(self, description_file: str):
        valid_keywords = ("vip_name", "has_master_and_slave", "trans_var", "if_port", "if_clock")
        with open(description_file, 'r') as f:
            for ln, line_str in enumerate(f):
                line_str = line_str.strip()
                line = line_str.split()
                # check for comments or misformatted file
                if not line or line[0][0] == "#":
                    continue
                elif len(line) < 3 or line[0] not in valid_keywords or line[1] != "=":
                    print_file_error("misformatted line",
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
                    self.if_clock = InterfacePort(args_str)
                elif keyword == "has_master_and_slave":
                    self.has_master_and_slave = args[0] == '1'
        # final checks
        if not self.vip_name:
            print_error(f"no vip_name found in {description_file}")
            exit(1)

    def get_loop_values(self):
        str_lists = StrLists()
        loop_dir = self.template_dir / "vip/.loop"
        port_loop_dir = loop_dir / "port"
        var_loop_dir = loop_dir / "var"
        var_if_array_loop_dir = var_loop_dir / "if_array"
        var_if_not_array_loop_dir = var_loop_dir / "if_not_array"
        clock_loop_dir = loop_dir / "clock"
        has_master_and_slave_loop_dir = loop_dir / "if_has_master_and_slave"
        not_has_master_and_slave_loop_dir = loop_dir / "if_not_has_master_and_slave"

        # ports
        fmt_values = {}
        for p in self.if_ports:
            fmt_values["port"] = p.signal_name
            fmt_values["port_definition"] = p.definition
            str_lists.append(format_template_dir(port_loop_dir, **fmt_values))

        # trans_vars
        fmt_values = {}
        for var in self.trans_vars:
            fmt_values["var"] = var.signal_name
            fmt_values["var_definition"] = var.definition
            str_lists.append(format_template_dir(var_loop_dir, **fmt_values))
            is_array = var.is_unpacked_array
            if is_array:
                str_lists.append(format_template_dir(
                    var_if_array_loop_dir, **fmt_values))
            else:
                str_lists.append(format_template_dir(
                    var_if_not_array_loop_dir, **fmt_values))

        # clock
        if self.if_clock:
            fmt_values = str_lists.to_dict()  # get port values
            fmt_values["clock"] = self.if_clock.signal_name
            fmt_values["clock_definition"] = self.if_clock.definition
            str_lists.append(
                format_template_dir(clock_loop_dir, **fmt_values))
        else:
            str_lists.append(
                format_template_dir(clock_loop_dir, force_empty_string=True))

        # master/slave
        fmt_values["vip"] = self.vip_name
        if self.has_master_and_slave:
            str_lists.append(format_template_dir(has_master_and_slave_loop_dir, **fmt_values))
        else:
            str_lists.append(format_template_dir(not_has_master_and_slave_loop_dir, **fmt_values))

        return str_lists.to_dict()

    def write_files(self):
        fmt_values = {
            "vip": self.vip_name,
            "upper_vip": self.vip_name.upper(),
            "clock_definition": self.if_clock.definition if self.if_clock else "",
            **self.get_loop_values()
        }
        for template_path in (self.template_dir / "vip").glob('*'):
            if template_path.is_dir():
                continue
            master_slave_template = template_path.match('*master*') or template_path.match('*slave*')
            if master_slave_template and not self.has_master_and_slave:
                continue
            output_path = self.vip_dir / \
                f"{self.vip_name}_{template_path.name}"
            Template(template_path).write(output_path, **fmt_values)
