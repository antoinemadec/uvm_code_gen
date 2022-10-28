import os
from pathlib import Path
import re


class Template:
    def __init__(self, template_path: Path):
        self.template_path = template_path
        if not self.template_path.exists():
            print_error(f"{self.template_path} does not exist")
            exit(1)
        self.template_stat = os.lstat(self.template_path)

    def format(self, **fmt_values) -> str:
        with self.template_path.open('r') as f:
            template = f.read()
        return template.format(**fmt_values)

    def write(self, output_path: Path, **fmt_values):
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with output_path.open('w') as f:
            f.write(self.format(**fmt_values))
        template_stat = os.lstat(self.template_path)
        os.chmod(output_path, template_stat.st_mode)

class StrLists:
    def __init__(self):
        self. sl = {}

    def append(self, fmt_values: dict[str, str]):
        for name in fmt_values:
            self.sl.setdefault(name, [])
            string = fmt_values[name][:-1]  # remove last "\n"
            self.sl[name].append(string)

    def to_dict(self):
        d = {}
        for name in self.sl:
            d[name] = "\n".join(self.sl[name])
            # remove last empty lines
            while True:
                sl = d[name].splitlines()
                d[name] = "\n".join(sl)
                if not sl or sl[-1] != '':
                    break
            # remove last comma
            if d[name] and d[name][-1] == ',':
                d[name] = d[name][:-1]
        return d

def get_template_dir(template_dir=""):
    path = os.path.abspath(__file__)
    dir_path = os.path.dirname(path)
    if not template_dir:
        template_dir = f"{dir_path}/template"
    return Path(template_dir)


def format_template_dir(template_dir_path: Path, force_empty_string= False, **fmt_values) -> dict[str, str]:
    d = {}
    for template_path in template_dir_path.glob('*'):
        if template_path.is_dir():
            continue
        name = template_path.name.split('.')[0]
        d[name] = "" if force_empty_string else Template(template_path).format(**fmt_values)
    return d


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
