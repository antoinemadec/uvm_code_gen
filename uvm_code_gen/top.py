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
        self.top_dir = Path(output_dir) / self.top_name
        self.template_dir = get_template_dir(template_dir)

    def fill_template(self, template_name: str, **fmt_values):
        template_path = self.template_dir / f"top/{template_name}.sv"
        output_path = self.top_dir / f"{self.top_name}_{template_name}.sv"
        fill_template(output_path, template_path, **fmt_values)

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
        return "\n".join([f"  {v.vip_name}_agent   m_{v.vip_name}_agent;" for v in self.vips])

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
                        f"      end\n")
        return "".join(seqs)

    def get_vip_declarations(self):
        declarations = []
        for v in self.vips:
            declarations.append(f"  {v.vip_name}_config   = m_{v.vip_name}_config;\n" +
                                f"  {v.vip_name}_agent    = m_{v.vip_name}_agent;\n" +
                                f"  {v.vip_name}_coverage = m_{v.vip_name}_coverage;")
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
            core.append(f"  m_{v.vip_name}_agent.analysis_port.connect(m_{v.vip_name}_coverage.analysis_export);")
        return "\n\n".join(core)

    def get_env_run_phase_core(self):
        return "\n".join([f"  vseq.m_{v.vip_name}_agent = m_{v.vip_name}_agent;" for v in self.vips])

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
            "env_run_phase_core": self.get_env_run_phase_core()
        }
        self.fill_template("config", **fmt_values)
        self.fill_template("env", **fmt_values)
        self.fill_template("seq_lib", **fmt_values)
        self.fill_template("pkg", **fmt_values)
