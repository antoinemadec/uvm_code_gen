#!/usr/bin/env bash

set -e

git_top="$1"
shift 1
output_dir="$1"
shift 1

cd "$git_top"
dut_path="$(realpath $git_top/test/dut/fifo.sv)"
echo "$dut_path" > ./$output_dir/bin/dut_files.f

sed -i '/(rst),/d' ./$output_dir/top/tb/top_th.sv
if [[ "$output_dir" =~ "map" ]]; then
  # dual fifo
  sed -i 's/dut/dual_fifo/g' ./$output_dir/top/tb/top_th.sv
  sed -i 's/\(\.\w*\)\(\W*(\w*\([0-1]\+\)\)/\1\3\2/' ./$output_dir/top/tb/top_th.sv
else
  # fifo
  sed -i 's/dut/fifo/g' ./$output_dir/top/tb/top_th.sv
fi

cd ./$output_dir/bin
./run
