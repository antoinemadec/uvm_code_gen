#!/usr/bin/env python3

import argparse
from uvm_code_gen import *

parser = argparse.ArgumentParser(
    description="simple template-based UVM code generator")

parser.add_argument("agent_description", nargs="+", help="agent description file used by the template")
args = parser.parse_args()

agents = []
for f in args.agent_description:
    agent = UvmAgent(f)
    agent.write_files()
    agents.append(agent)
