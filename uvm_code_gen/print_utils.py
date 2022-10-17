"""Print function standaradizing error, warning, header etc"""


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


def print_header(s: str):
    print("{}\n-- {}{}".format(Colors.HEADER, s, Colors.ENDC))


def print_warning(s: str):
    print("{}[WARNING]{} {}".format(Colors.WARNING, Colors.ENDC, s))


def print_error(s: str):
    print("{}[ERROR]{} {}".format(Colors.FAIL, Colors.ENDC, s))

def print_file_error(error_msg:str, file:str, line:int, line_str=""):
    print_error(f"{error_msg}. File \"{file}\", line {line}\n{line_str}")
