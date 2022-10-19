import os
from pathlib import Path
import re


class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def get_template_dir(template_dir=""):
    path = os.path.abspath(__file__)
    dir_path = os.path.dirname(path)
    if not template_dir:
        template_dir = f"{dir_path}/template"
    return Path(template_dir)


def fill_template(output_path: Path, template_path: Path, **fmt_values):
    if not template_path.exists():
        print_error(f"{template_path} does not exist")
        exit(1)
    template_stat = os.lstat(template_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with template_path.open('r') as f:
        template = f.read()
    with output_path.open('w') as f:
        f.write(template.format(**fmt_values))
    os.chmod(output_path, template_stat.st_mode)


class SvCode(object):
    def __init__(self, line_of_code: str):
        self.line_of_code = line_of_code
        self.__signal_name = None
        self.__is_unpacked_array = None

    def get_signal_name(self) -> str:
        if not self.__signal_name:
            replacements = [
                (';.*', ''),
                (r'\[[^\[\]]*\]', ''),
                (r'\(\w\s\)*\s*', '')
            ]
            s = self.line_of_code
            for pattern, repl in replacements:
                s = re.sub(pattern, repl, s)
            self.__signal_name = s.split()[-1]
        return self.__signal_name

    def get_is_unpacked_array(self) -> bool:
        if not self.__is_unpacked_array:
            signal_name = self.get_signal_name()
            replacements = [
                (f".*{signal_name}", ''),
                (';.*', '')
            ]
            s = self.line_of_code
            for pattern, repl in replacements:
                s = re.sub(pattern, repl, s)
            self.__is_unpacked_array = bool(re.match(r".*\[.*\]", s))
        return self.__is_unpacked_array


def print_header(s: str):
    print("{}\n-- {}{}".format(Colors.HEADER, s, Colors.ENDC))


def print_warning(s: str):
    print("{}[WARNING]{} {}".format(Colors.WARNING, Colors.ENDC, s))


def print_error(s: str):
    print("{}[ERROR]{} {}".format(Colors.FAIL, Colors.ENDC, s))


def print_file_error(error_msg: str, file: str, line: int, line_str=""):
    print_error(f"{error_msg}. File \"{file}\", line {line}\n{line_str}")
