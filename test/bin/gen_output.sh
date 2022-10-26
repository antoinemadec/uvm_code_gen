#!/usr/bin/env bash

set -e


git_top="$1"
shift 1
output_dir="$1"
shift 1
cmd_line="$@"

cd "$git_top"
rm -rf output
cmd="./main.py $cmd_line"
$cmd
echo $cmd > output/cmd.txt
rm -rf $output_dir
mv output $output_dir
