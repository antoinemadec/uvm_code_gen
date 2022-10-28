from .utils import *
from .vip import UvmVip


class UvmTop(object):
    """parse template and create UVM verification top-level environment"""

    def __init__(self,
                 vips: list[UvmVip],
                 vip_instances: dict[str, list[str]],
                 top_name: str = "top",
                 output_dir: str = "./output",
                 template_dir: str = ""):
        # description
        self.vips = vips
        self.vip_instances = vip_instances
        self.top_name = top_name
        # output
        self.output_dir = Path(output_dir)
        self.template_dir = get_template_dir(template_dir)

    def get_loop_values(self, template_rel_dir: str):
        str_lists = StrLists()
        vip_loop_dir = self.template_dir / template_rel_dir / ".loop/vip"
        inst_loop_dir = vip_loop_dir / "inst"
        clock_loop_dir = vip_loop_dir / "inst/clock"
        has_master_and_slave_loop_dir = vip_loop_dir / "inst/if_has_master_and_slave"
        not_has_master_and_slave_loop_dir = vip_loop_dir / "inst/if_not_has_master_and_slave"
        port_loop_dir = vip_loop_dir / "inst/port"
        fmt_values = {"top": self.top_name}

        for v in self.vips:
            vip = v.vip_name
            fmt_values["vip"] = vip
            str_lists.append(format_template_dir(vip_loop_dir, **fmt_values))
            for inst in self.vip_instances[vip]:
                fmt_values["inst"] = inst
                str_lists.append(
                    format_template_dir(inst_loop_dir, **fmt_values))
                # master/slave
                if v.has_master_and_slave:
                    fmt_values["is_master"] = "1" if "master" in inst else "0"
                    str_lists.append(
                        format_template_dir(has_master_and_slave_loop_dir, **fmt_values))
                else:
                    str_lists.append(
                        format_template_dir(not_has_master_and_slave_loop_dir, **fmt_values))
                # clock
                if v.if_clock:
                    fmt_values["clock"] = v.if_clock.signal_name
                    str_lists.append(
                        format_template_dir(clock_loop_dir, **fmt_values))
                else:
                    str_lists.append(
                        format_template_dir(clock_loop_dir, force_empty_string=True))
                # ports
                if v.if_ports:
                    for p in v.if_ports:
                        fmt_values["port"] = p.signal_name
                        str_lists.append(
                            format_template_dir(port_loop_dir, **fmt_values))
                else:
                    # when present in top_map but vip_config is not provided, no ports are defined
                    str_lists.append(
                        format_template_dir(port_loop_dir, force_empty_string=True))

        return str_lists.to_dict()

    def write_file(self, template_path: Path, **fmt_values):
        rel_path = template_path.relative_to(self.template_dir)
        parts = rel_path.parts
        if parts[0] == "top":
            top = self.top_name
            output_rel_path = f"{top}/{'/'.join(parts[1:-1])}/{top}_{parts[-1]}"
        else:
            output_rel_path = rel_path
        Template(template_path).write(
            self.output_dir / output_rel_path, **fmt_values)

    def write_files(self):
        fmt_values = {
            "top": self.top_name,
            "upper_top": self.top_name.upper(),
            **self.get_loop_values("top"),
            **self.get_loop_values("bin")}
        for rel_dir in "top", "top/tb", "top/test", "bin":
            for path in (self.template_dir / rel_dir).glob('*'):
                if not path.is_dir():
                    self.write_file(path, **fmt_values)
