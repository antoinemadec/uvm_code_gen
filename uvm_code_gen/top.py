from .utils import *
from .vip import UvmVip


class UvmTop(object):
    """parse template and create UVM verification top-level environment"""

    def __init__(self,
                 vips: list[UvmVip],
                 top_name: str = "top",
                 output_dir: str = "./output",
                 template_dir: str = ""):
        # description
        self.vips = vips
        self.top_name = top_name
        # output
        self.output_dir = Path(output_dir)
        self.template_dir = get_template_dir(template_dir)

    def fill_template(self, template_rel_path: str, **fmt_values):
        trp_list = template_rel_path.split('/')
        output_rel_path = template_rel_path
        if trp_list[0] == "top":
            top = self.top_name
            output_rel_path = f"{top}/{'/'.join(trp_list[1:-1])}/{top}_{trp_list[-1]}"
        fill_template(self.output_dir / output_rel_path,
                      self.template_dir / template_rel_path, **fmt_values)

    def get_vip_imports(self):
        return "\n".join([f"  import {v.vip_name}_pkg::*;" for v in self.vips])

    def get_config_declarations(self):
        return "\n".join([f"  rand {v.vip_name}_config m_{v.vip_name}_config;" for v in self.vips])

    def get_config_new_core(self):
        configs = []
        for v in self.vips:
            vip = v.vip_name
            configs.append(f"  m_{vip}_config = new(\"m_{vip}_config\");\n" +
                           f"  m_{vip}_config.is_active = UVM_ACTIVE;\n" +
                           f"  m_{vip}_config.checks_enable = 1;\n" +
                           f"  m_{vip}_config.coverage_enable = 1;")
        return "\n\n".join(configs)

    def get_agent_declarations(self):
        return "\n".join([f"  {v.vip_name}_agent m_{v.vip_name}_agent;" for v in self.vips])

    def get_seq_body_core(self):
        seqs = []
        for v in self.vips:
            vip = v.vip_name
            seqs.append(f"      if (m_{vip}_agent.m_config.is_active == UVM_ACTIVE)\n" +
                        f"      begin\n" +
                        f"        {vip}_default_seq seq;\n" +
                        f"        seq = {vip}_default_seq::type_id::create(\"seq\");\n" +
                        f"        seq.set_item_context(this, m_{vip}_agent.m_sequencer);\n" +
                        f"        if ( !seq.randomize() )\n" +
                        f"          `uvm_error(get_type_name(), \"Failed to randomize sequence\")\n" +
                        f"        seq.m_config = m_{vip}_agent.m_config;\n" +
                        f"        seq.set_starting_phase( get_starting_phase() );\n" +
                        f"        seq.start(m_{vip}_agent.m_sequencer, this);\n" +
                        f"      end")
        return "\n".join(seqs)

    def get_vip_declarations(self):
        declarations = []
        for v in self.vips:
            vip = v.vip_name
            declarations.append(f"  {vip}_config   m_{vip}_config;\n" +
                                f"  {vip}_agent    m_{vip}_agent;\n" +
                                f"  {vip}_coverage m_{vip}_coverage;")
        return "\n\n".join(declarations)

    def get_env_build_phase_core(self):
        core = []
        for v in self.vips:
            vip = v.vip_name
            core.append(f"  m_{vip}_config = m_config.m_{vip}_config;\n" +
                        f"  uvm_config_db #({vip}_config)::set(this, \"m_{vip}_agent\", \"config\", m_{vip}_config);\n" +
                        f"  if (m_{vip}_config.is_active == UVM_ACTIVE )\n" +
                        f"    uvm_config_db #({vip}_config)::set(this, \"m_{vip}_agent.m_sequencer\", \"config\", m_{vip}_config);\n" +
                        f"  uvm_config_db #({vip}_config)::set(this, \"m_{vip}_coverage\", \"config\", m_{vip}_config);\n\n" +
                        f"  m_{vip}_agent = {vip}_agent::type_id::create(\"m_{vip}_agent\", this);\n" +
                        f"  m_{vip}_coverage = {vip}_coverage::type_id::create(\"m_{vip}_coverage\", this);")
        return "\n\n".join(core)

    def get_env_connect_phase_core(self):
        core = []
        for v in self.vips:
            vip = v.vip_name
            core.append(f"  m_{vip}_agent.analysis_port.connect(m_{vip}_coverage.analysis_export);\n" +
                        f"  m_{vip}_agent.analysis_port.connect(m_scoreboard.{vip}_to_scoreboard);")
        return "\n\n".join(core)

    def get_env_run_phase_core(self):
        return "\n".join([f"  vseq.m_{v.vip_name}_agent = m_{v.vip_name}_agent;" for v in self.vips])

    def get_sb_fmt_values(self) -> dict[str, str]:
        sb_analysis_imp_macros = []
        sb_analysis_imp_declaration = []
        sb_analysis_imp_new = []
        sb_writes = []
        top = self.top_name
        for v in self.vips:
            vip = v.vip_name
            sb_analysis_imp_macros.append(
                f"`uvm_analysis_imp_decl(_from_{vip})")
            sb_analysis_imp_declaration.append(
                f"  uvm_analysis_imp_from_{vip} #({vip}_tx, {top}_scoreboard) {vip}_to_scoreboard;")
            sb_analysis_imp_new.append(
                f"     {vip}_to_scoreboard = new(\"{vip}_to_scoreboard\", this);")
            sb_writes.append(
                f"  virtual function void write_from_{vip}(input {vip}_tx pkt);\n" +
                f"    `uvm_info(get_type_name(), $sformatf(\"Received {vip}_tx: %s\",\n" +
                f"      pkt.sprint( uvm_default_line_printer )), UVM_HIGH)\n" +
                f"  endfunction: write_from_{vip}")
        d = {
            "sb_analysis_imp_macros": "\n".join(sb_analysis_imp_macros),
            "sb_analysis_imp_declaration": "\n".join(sb_analysis_imp_declaration),
            "sb_analysis_imp_new": "\n".join(sb_analysis_imp_new),
            "sb_writes": "\n\n\n".join(sb_writes)
        }
        return d

    def get_xrun_core(self):
        core = []
        core += [f"  +incdir+$VIP_DIR/{v.vip_name} \\" for v in self.vips]
        core.append(f"  +incdir+$TOP_DIR \\")
        core.append(f"  +incdir+$TOP_DIR/test \\")
        core.append(f"  -F $BIN_DIR/dut_files.f \\")
        top = self.top_name
        for v in self.vips:
            vip = v.vip_name
            for s in ("pkg", "if"):
                core.append(f"  $VIP_DIR/{vip}/{vip}_{s}.sv \\")
        core.append(f"  $TOP_DIR/{top}_pkg.sv \\")
        core.append(f"  $TOP_DIR/test/{top}_test_pkg.sv \\")
        core.append(f"  $TOP_DIR/tb/{top}_th.sv \\")
        core.append(f"  $TOP_DIR/tb/{top}_tb.sv \\")
        core.append(f"  +UVM_TESTNAME={top}_test  $*")
        return "\n".join(core)

    def get_interface_and_dut_instantiation(self):
        inst = []
        inst += [f"  {v.vip_name}_if {v.vip_name}_if();" for v in self.vips]
        inst.append("")
        dut_inst = []
        for v in self.vips:
            vip = v.vip_name
            if v.if_clock:
                clock = v.if_clock.signal_name
                inst.append(f"  assign {vip}_if.{clock} = clk;")
            for p in v.if_ports:
                port = p.signal_name
                dut_inst.append(f"    .{port} ({vip}_if.{port})")
        dut_inst_str = ",\n".join(dut_inst)
        inst.append(
            f"\n  dut dut(\n    .clk (clk),\n    .rst (rst),\n{dut_inst_str}\n  );")
        return "\n".join(inst)

    def write_files(self):
        fmt_values = {
            "top_name": self.top_name,
            "upper_top_name": self.top_name.upper(),
            "vip_imports": self.get_vip_imports(),
            "config_declarations": self.get_config_declarations(),
            "config_new_core": self.get_config_new_core(),
            "agent_declarations": self.get_agent_declarations(),
            "seq_body_core": self.get_seq_body_core(),
            "vip_declarations": self.get_vip_declarations(),
            "env_build_phase_core": self.get_env_build_phase_core(),
            "env_connect_phase_core": self.get_env_connect_phase_core(),
            "env_run_phase_core": self.get_env_run_phase_core(),
            "xrun_core": self.get_xrun_core(),
            "interface_and_dut_instantiation": self.get_interface_and_dut_instantiation()
        }
        fmt_values = {**fmt_values, **self.get_sb_fmt_values()}
        self.fill_template("top/config.sv", **fmt_values)
        self.fill_template("top/env.sv", **fmt_values)
        self.fill_template("top/scoreboard.sv", **fmt_values)
        self.fill_template("top/seq_lib.sv", **fmt_values)
        self.fill_template("top/pkg.sv", **fmt_values)
        self.fill_template("top/tb/tb.sv", **fmt_values)
        self.fill_template("top/tb/th.sv", **fmt_values)
        self.fill_template("top/test/test.sv", **fmt_values)
        self.fill_template("top/test/test_pkg.sv", **fmt_values)
        self.fill_template("bin/run", **fmt_values)
