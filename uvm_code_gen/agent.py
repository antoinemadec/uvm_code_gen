from .print_utils import *
import re


class TransactionVariable(object):
    def __init__(self, definition:str):
        self.definition = definition;


class InterfacePort(object):
    def __init__(self, definition:str, is_clock=False):
        self.definition = definition;
        self.is_clock = is_clock;

    def update_is_clock(self, signal_is_clock:str):
        for e in re.split(',|;| ', self.definition):
            if e == signal_is_clock:
                self.is_clock = True
                return


class UvmAgent(object):
    """parse template and create UVM Agent"""
    def __init__(self, description_file:str):
        self.agent_name = ""
        self.if_ports:list[InterfacePort] = []
        self.trans_vars:list[TransactionVariable] = []
        self.parse_description_file(description_file)

    def parse_description_file(self, description_file:str):
        valid_keywords = ("agent_name", "trans_var", "if_port", "if_clock")
        if_clock = ""
        with open(description_file, 'r') as f:
            for ln, line_str in enumerate(f):
                line_str = line_str.strip()
                line = line_str.split()
                # check for comments or misformatted file
                if not line or line[0][0] == "#":
                    continue
                elif len(line) < 3:
                    print_file_error("too few arguments", description_file, ln+1, line_str)
                    exit(1)
                elif line[0] not in valid_keywords:
                    print_file_error(f"invalid keyword \"{line[0]}\"", description_file, ln+1, line_str)
                    exit(1)
                elif line[1] != "=":
                    print_file_error(f"missing \"=\"", description_file, ln+1, line_str)
                    exit(1)
                # parse valid keywords
                keyword = line[0]
                args = line[2:]
                args_str = " ".join(args)
                if keyword == "agent_name":
                    if len(args) != 1:
                        print_file_error(f"agent_name expect only 1 value", description_file, ln+1, line_str)
                        exit(1)
                    self.agent_name = args[0]
                elif keyword == "trans_var":
                    self.trans_vars.append(TransactionVariable(args_str))
                elif keyword == "if_port":
                    self.if_ports.append(InterfacePort(args_str))
                elif keyword == "if_clock":
                    if_clock = args[0]

        # post processing and final checks
        for p in self.if_ports:
            p.update_is_clock(if_clock)
        if not self.agent_name:
            print_error(f"no agent_name found in {description_file}")
            exit(1)
