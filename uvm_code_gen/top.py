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
        if  trp_list[0] == "top":
            output_rel_path = f"{self.top_name}/{'/'.join(trp_list[1:-1])}/{self.top_name}_{trp_list[-1]}"
        fill_template(self.output_dir / output_rel_path, self.template_dir / template_rel_path, **fmt_values)

    def get_vip_imports(self):
        return "\n".join([f"  import {v.vip_name}_pkg::*;" for v in self.vips])

    def get_config_declarations(self):
        return "\n".join([f"  rand {v.vip_name}_config m_{v.vip_name}_config;" for v in self.vips])

    def get_config_new_core(self):
        configs = []
        for v in self.vips:
            configs.append(f"  m_{v.vip_name}_config = new(\"m_{v.vip_name}_config\");\n" +
                           f"  m_{v.vip_name}_config.is_active = UVM_ACTIVE;\n" +
                           f"  m_{v.vip_name}_config.checks_enable = 1;\n" +
                           f"  m_{v.vip_name}_config.coverage_enable = 1;")
        return "\n\n".join(configs)

    def get_agent_declarations(self):
        return "\n".join([f"  {v.vip_name}_agent m_{v.vip_name}_agent;" for v in self.vips])

    def get_seq_body_core(self):
        seqs = []
        for v in self.vips:
            seqs.append(f"      if (m_{v.vip_name}_agent.m_config.is_active == UVM_ACTIVE)\n" +
                        f"      begin\n" +
                        f"        {v.vip_name}_default_seq seq;\n" +
                        f"        seq = {v.vip_name}_default_seq::type_id::create(\"seq\");\n" +
                        f"        seq.set_item_context(this, m_{v.vip_name}_agent.m_sequencer);\n" +
                        f"        if ( !seq.randomize() )\n" +
                        f"          `uvm_error(get_type_name(), \"Failed to randomize sequence\")\n" +
                        f"        seq.m_config = m_{v.vip_name}_agent.m_config;\n" +
                        f"        seq.set_starting_phase( get_starting_phase() );\n" +
                        f"        seq.start(m_{v.vip_name}_agent.m_sequencer, this);\n" +
                        f"      end")
        return "\n".join(seqs)

    def get_vip_declarations(self):
        declarations = []
        for v in self.vips:
            declarations.append(f"  {v.vip_name}_config   m_{v.vip_name}_config;\n" +
                                f"  {v.vip_name}_agent    m_{v.vip_name}_agent;\n" +
                                f"  {v.vip_name}_coverage m_{v.vip_name}_coverage;")
        return "\n\n".join(declarations)

    def get_env_build_phase_core(self):
        core = []
        for v in self.vips:
            core.append(f"  m_{v.vip_name}_config = m_config.m_{v.vip_name}_config;\n" +
                        f"  uvm_config_db #({v.vip_name}_config)::set(this, \"m_{v.vip_name}_agent\", \"config\", m_{v.vip_name}_config);\n" +
                        f"  if (m_{v.vip_name}_config.is_active == UVM_ACTIVE )\n" +
                        f"    uvm_config_db #({v.vip_name}_config)::set(this, \"m_{v.vip_name}_agent.m_sequencer\", \"config\", m_{v.vip_name}_config);\n" +
                        f"  uvm_config_db #({v.vip_name}_config)::set(this, \"m_{v.vip_name}_coverage\", \"config\", m_{v.vip_name}_config);\n\n" +
                        f"  m_{v.vip_name}_agent = {v.vip_name}_agent::type_id::create(\"m_{v.vip_name}_agent\", this);\n" +
                        f"  m_{v.vip_name}_coverage = {v.vip_name}_coverage::type_id::create(\"m_{v.vip_name}_coverage\", this);")
        return "\n\n".join(core)

    def get_env_connect_phase_core(self):
        core = []
        for v in self.vips:
            core.append(f"  m_{v.vip_name}_agent.analysis_port.connect(m_{v.vip_name}_coverage.analysis_export);\n" +
                        f"  m_{v.vip_name}_agent.analysis_port.connect(m_scoreboard.{v.vip_name}_to_scoreboard);")
        return "\n\n".join(core)

    def get_env_run_phase_core(self):
        return "\n".join([f"  vseq.m_{v.vip_name}_agent = m_{v.vip_name}_agent;" for v in self.vips])

    def get_sb_fmt_values(self) -> dict[str, str]:
        sb_analysis_imp_macros = []
        sb_analysis_imp_declaration = []
        sb_analysis_imp_new = []
        sb_writes = []
        for v in self.vips:
            vip = v.vip_name
            top = self.top_name
            sb_analysis_imp_macros.append(f"`uvm_analysis_imp_decl(_from_{vip})")
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
        for v in self.vips:
            for s in ("pkg", "if"):
                core.append(f"  $VIP_DIR/{v.vip_name}/{v.vip_name}_{s}.sv \\")
        core.append(f"  $TOP_DIR/{self.top_name}_pkg.sv \\")
        core.append(f"  $TOP_DIR/test/{self.top_name}_test_pkg.sv \\")
        core.append(f"  $TOP_DIR/tb/{self.top_name}_th.sv \\")
        core.append(f"  $TOP_DIR/tb/{self.top_name}_tb.sv \\")
        core.append(f"  +UVM_TESTNAME={self.top_name}_test  $*")
        return "\n".join(core)
    
    def get_interface_and_dut_instantiation(self):
        inst = []
        inst += [f"  {v.vip_name}_if {v.vip_name}_if();" for v in self.vips]
        inst.append("")
        dut_inst = []
        for v in self.vips:
            for p in v.if_ports:
                if p.is_clock:
                    inst.append(f"  assign {v.vip_name}_if.clk = clk;")
                else:
                    dut_inst.append(f"    .{p.signal_name} ({v.vip_name}_if.{p.signal_name})")
        dut_inst_str = ",\n".join(dut_inst)
        inst.append(f"\n  dut dut(\n    .clk (clk),\n    .rst (rst),\n{dut_inst_str}\n  );")
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
