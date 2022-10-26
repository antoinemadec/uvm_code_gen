#!/usr/bin/env bash

set -e

git_top="$1"
shift 1
output_dir="$1"
shift 1

cd "$git_top"
dut_path="$($git_top/test/dut/fifo.sv)"
output_dir="output_fifo"
echo "$dut_path" > ./$output_dir/bin/dut_files.f
sed -i 's/dut/fifo/g' ./$output_dir/top/tb/top_th.sv
sed -i '/(rst),/d' ./$output_dir/top/tb/top_th.sv

cd ./$output_dir/bin
./run
