#!/usr/bin/env python3

from pathlib import Path
import shutil
import subprocess
import filecmp


# --------------------------------------------------------------
# functions
# --------------------------------------------------------------
def bash(cmd: str | list[str], error_ok=False) -> str:
    if type(cmd) is str:
        cmd = cmd.split()
    if error_ok:
        return subprocess.getoutput(" ".join(cmd))
    return subprocess.check_output(cmd).decode('utf-8').strip()


def print_diff_files(dcmp) -> bool:
    global GIT_TOP
    ok = True
    left = str(Path(dcmp.left).relative_to(GIT_TOP))
    right = str(Path(dcmp.right).relative_to(GIT_TOP))
    d = {
        "diff_files": [dcmp.diff_files, "\033[91m%s\033[0m differs in %s and %s"],
        "right_only": [dcmp.right_only, "\033[91m%s\033[0m not found in %s, found in %s"],
        "left_only": [dcmp.left_only, "\033[91m%s\033[0m found in %s, not found in %s"],
    }
    for name in d:
        list, string = d[name]
        for file in list:
            ok = False
            print(string % (file, left, right))
            if name == "diff_files":
                print(bash(f"diff {GIT_TOP}/{left}/{file} {GIT_TOP}/{right}/{file} --color=always",
                           error_ok=True))
    for sub_dcmp in dcmp.subdirs.values():
        if not print_diff_files(sub_dcmp):
            ok = False
    return ok


def run_fifo(output_dir: str | Path):
    global GIT_TOP
    script = f"{GIT_TOP}/test/bin/run_fifo.sh"
    print(f"-- run {output_dir}")
    bash(f"{script} {GIT_TOP} {output_dir}")


def gen_output_core(output_dir: str | Path, args: str):
    global GIT_TOP
    script = f"{GIT_TOP}/test/bin/gen_output.sh"
    print(f"-- gen {output_dir}")
    bash(f"{script} {GIT_TOP} {output_dir} {args}")


def gen_output(example_name: str) -> bool:
    global GIT_TOP
    example_dir = GIT_TOP / f"examples/{example_name}"
    configs = " ".join([str(p.relative_to(GIT_TOP))
                       for p in example_dir.glob("*.conf")])
    top_map = " ".join(
        [f"--top_map {p.relative_to(GIT_TOP)}" for p in example_dir.glob("*.map")])

    ok = True
    for case in range(3):
        output_name = ""
        args = ""
        if case == 0 and configs:
            output_name = f"output_{example_name}_config"
            args = configs
        if case == 1 and top_map:
            output_name = f"output_{example_name}_map"
            args = top_map
        if case == 2 and configs and top_map:
            output_name = f"output_{example_name}_config_and_map"
            args = f"{configs} {top_map}"
        if output_name:
            gen_output_core(output_name, args)
            ref_dir = GIT_TOP / f"test/ref/{output_name}"
            output_dir = GIT_TOP / f"{output_name}"
            dcmp = filecmp.dircmp(ref_dir, output_dir)
            if not print_diff_files(dcmp):
                ok = False
    return ok


# --------------------------------------------------------------
# execution
# --------------------------------------------------------------
GIT_TOP = Path(bash("git rev-parse --show-toplevel"))
for example in "fifo", "noc":
    ok = gen_output(example)
    if not ok:
        exit(1)

if shutil.which("xrun"):
    run_fifo("output_fifo_config")
    run_fifo("output_fifo_config_and_map")
