#!/usr/bin/env bash

set -e

git_top="$1"
shift 1
output_dir="$1"
shift 1

cd "$git_top"
touch ./$output_dir/bin/dut_files.f

sed -i '/dut dut/d' ./$output_dir/top/tb/top_th.sv
sed -i '/^ *\./d' ./$output_dir/top/tb/top_th.sv
sed -i '/^ *);/d' ./$output_dir/top/tb/top_th.sv

cd ./$output_dir/bin
./run
