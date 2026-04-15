import os
from pathlib import Path
import re
from typing import Dict


class Template:
    """Reads a template file and renders it by substituting format values."""

    def __init__(self, template_path: Path):
        """Load template from path, verifying it exists."""
        self.template_path = template_path
        if not self.template_path.exists():
            print_error(f"{self.template_path} does not exist")
            exit(1)
        self.template_stat = os.lstat(self.template_path)

    def format(self, **fmt_values) -> str:
        """Return the rendered template string with substituted values."""
        with self.template_path.open('r') as f:
            template = f.read()
        return template.format(**fmt_values)

    def write(self, output_path: Path, **fmt_values):
        """Render the template and write the result to output_path, preserving file permissions."""
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with output_path.open('w') as f:
            f.write(self.format(**fmt_values))
        template_stat = os.lstat(self.template_path)
        os.chmod(output_path, template_stat.st_mode)

class StrLists:
    """Accumulates lists of rendered string values keyed by name, for joining into final format values."""

    def __init__(self):
        self. sl = {}

    def append(self, fmt_values: Dict[str, str]):
        """Add a dict of name->string entries, stripping each trailing newline."""
        for name in fmt_values:
            self.sl.setdefault(name, [])
            string = fmt_values[name][:-1]  # remove last "\n"
            self.sl[name].append(string)

    def to_dict(self):
        """Return accumulated lists joined by newlines, with trailing empty lines and trailing commas removed."""
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
    """Return the Path to the template directory, defaulting to the package's built-in template/ folder."""
    path = os.path.abspath(__file__)
    dir_path = os.path.dirname(path)
    if not template_dir:
        template_dir = f"{dir_path}/template"
    return Path(template_dir)


def format_template_dir(template_dir_path: Path, force_empty_string= False, **fmt_values) -> Dict[str, str]:
    """Render all template files in a directory and return a dict of stem->rendered string."""
    d = {}
    for template_path in template_dir_path.glob('*'):
        if template_path.is_dir():
            continue
        name = template_path.name.split('.')[0]
        d[name] = "" if force_empty_string else Template(template_path).format(**fmt_values)
    return d


class SvCode(object):
    """Parses a SystemVerilog signal declaration to extract signal metadata."""

    def __init__(self, line_of_code: str):
        self.line_of_code = line_of_code
        self.__signal_name = None
        self.__is_unpacked_array = None

    def get_signal_name(self) -> str:
        """Return the signal name extracted from the declaration."""
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
        """Return True if the signal has an unpacked array dimension after its name."""
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
    """Print a section header in the terminal."""
    print("{}\n-- {}{}".format(Colors.HEADER, s, Colors.ENDC))


def print_warning(s: str):
    """Print a warning message."""
    print("{}[WARNING]{} {}".format(Colors.WARNING, Colors.ENDC, s))


def print_error(s: str):
    """Print an error message."""
    print("{}[ERROR]{} {}".format(Colors.FAIL, Colors.ENDC, s))


def print_file_error(error_msg: str, file: str, line: int, line_str=""):
    """Print an error message referencing a specific file and line number."""
    print_error(f"{error_msg}. File \"{file}\", line {line}\n{line_str}")


class Colors:
    """ANSI color codes for terminal output."""

    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
