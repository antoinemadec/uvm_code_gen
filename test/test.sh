#!/usr/bin/env bash

set -e

GIT_TOP="$(git rev-parse --show-toplevel)"


#--------------------------------------------------------------
# functions
#--------------------------------------------------------------
gen_output_core() {
  local output_dir="$1"
  shift 1
  local cmd_line="$@"
  echo "$output_dir: $cmd_line"
  cd "$GIT_TOP"
  rm -rf output
  ./main.py $cmd_line
  rm -rf $output_dir
  mv output $output_dir
}

gen_output() {
  local example_name="$1"
  local example_dir="examples/$example_name"
  local output_dir="output_$example_name"
  local configs=0
  local top_map=0
  cd $GIT_TOP
  ls $example_dir/*.conf &> /dev/null && configs=1
  ls $example_dir/top.map &> /dev/null && top_map=1
  if ((configs)); then
    gen_output_core ${output_dir}_conf $example_dir/*.conf
  fi
  if ((top_map)); then
    gen_output_core ${output_dir}_map --top_map $example_dir/top.map
  fi
  if ((configs && top_map)); then
    gen_output_core ${output_dir}_conf_map $example_dir/*.conf --top_map $example_dir/top.map
  fi
}


#--------------------------------------------------------------
# execution
#--------------------------------------------------------------
# generate outputs
gen_output "fifo"
gen_output "noc"

if type xrun &> /dev/null; then
  # run fifo example
  cd "$GIT_TOP"
  dut_path="$(realpath ./test/dut/fifo.sv)"
  output_dir="output_fifo"
  echo "$dut_path" > ./$output_dir/bin/dut_files.f
  sed -i 's/dut/fifo/g' ./$output_dir/top/tb/top_th.sv
  sed -i '/(rst),/d' ./$output_dir/top/tb/top_th.sv

  cd ./$output_dir/bin
  ./run
fi
