#!/usr/bin/env bash

set -e

cd $(git rev-parse --show-toplevel)

files="$(git ls-files | grep '\(main\|uvm_code_gen\)')"
wc -l $files
