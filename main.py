#!/usr/bin/env python3

import argparse

from uvm_code_gen import *


# argument parsing
parser = argparse.ArgumentParser(
    description="simple template-based UVM code generator")

parser.add_argument("vip_config", nargs="*", help="vip configuration file used by the templates")
parser.add_argument("-t", "--top_env_name", help="name of top-level verif environment (default is top)", default="top")
parser.add_argument("--top_map", help="force VIP -> instance(s) mapping in top-level verif environment")
parser.add_argument("--no_vip", action='store_true', help="don't generate VIPs")
parser.add_argument("--no_top", action='store_true', help="don't generate top-level verif environment")
args = parser.parse_args()


# VIP
vips: list[UvmVip] = []
for f in args.vip_config:
    vip = UvmVip(description_file=f, output_dir="./output/vip")
    if not args.no_vip:
        vip.write_files()
    vips.append(vip)


# VIP -> instances map
vip_instances: dict[str, list[str]] = {}
if not args.top_map:
    # default map
    for v in vips:
        if v.has_master_and_slave:
            vip_instances[v.vip_name] = [f"{v.vip_name}_master", f"{v.vip_name}_slave"]
        else:
            vip_instances[v.vip_name] = [v.vip_name]
else:
    # custom map
    with open(args.top_map, 'r') as f:
        for line in f:
            lsplit = line.split()
            if not lsplit or lsplit[0] == "#":
                continue
            if len(lsplit) != 2:
                print_error(f"{args.top_map} format is incorrect")
                exit(1)
            vip, instance = lsplit
            vip_instances[vip] = vip_instances.get(vip, []) + [instance]
    # check VIP is present in the top_map
    vnames = [v.vip_name for v in vips]
    map_vnames = [vname for vname in vip_instances]
    for vname in vnames:
        if vname not in map_vnames:
            print_error(f"VIP {vname} not present in {args.top_map}")
            exit(1)
    # create basic VIPs when present in top_map but vip_config is not provided
    for vname in map_vnames:
        if vname not in vnames:
            vip = UvmVip()
            vip.vip_name = vname
            vips.append(vip)


# top-level verif environment
top = UvmTop(vips, vip_instances=vip_instances,
             top_name=args.top_env_name, output_dir=f"./output")
if not args.no_top:
    top.write_files()
