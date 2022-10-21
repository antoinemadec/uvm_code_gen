#!/usr/bin/env bash

set -e

git_top="$(git rev-parse --show-toplevel)"
cd "$git_top"
rm -rf output

# generate UVM testbench
./main.py ./examples/fifo_*.conf

# create dut_files.f
dut_path="(realpath ./examples/dut/fifo.sv)"
echo "$dut_path" > ./output/bin/dut_files.f

# edit dut instatiation
sed -i 's/dut/fifo/g' ./output/top/tb/top_th.sv
sed -i '/(rst),/d' ./output/top/tb/top_th.sv

# run
cd ./output/bin
./run
