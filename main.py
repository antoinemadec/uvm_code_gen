#!/usr/bin/env python3

import argparse

from uvm_code_gen import *

parser = argparse.ArgumentParser(
    description="simple template-based UVM code generator",
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument("-t", "--top_env_name", help="name of top-level verif environment (default is top)", default="top")
parser.add_argument("--vip_only", action='store_true', help="only generates VIPs, do not generate top-level verif environment")
parser.add_argument("vip_config", nargs="+", help="vip configuration file used by the templates")
args = parser.parse_args()

vips:list[UvmVip] = []
for f in args.vip_config:
    vip = UvmVip(f, output_dir="./output/vip")
    vip.write_files()
    vips.append(vip)

if not args.vip_only:
    top = UvmTop(vips, top_name=args.top_env_name, output_dir=f"./output")
    top.write_files()
