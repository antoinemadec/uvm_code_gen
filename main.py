#!/usr/bin/env python3

import argparse
from uvm_code_gen import *

parser = argparse.ArgumentParser(
    description="simple template-based UVM code generator")

parser.add_argument("vip_config", nargs="+", help="vip configuration file used by the templates")
args = parser.parse_args()

vips = []
for f in args.vip_config:
    vip = UvmVip(f, output_dir="")
    vip.write_files()
    vips.append(vip)
