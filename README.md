# ⚡️ uvm_code_gen
Simple template-based UVM code generator.

## 💡 Rationale
[UVM](https://en.wikipedia.org/wiki/Universal_Verification_Methodology) is great for reuse and standardization of RTL verification.  
However, it is very verbose.

**uvm_code_gen** generates a full UVM testbench skeleton based on simple configuration files.  
Once generated, we only have to write a couple of lines to finish it.

## ✨ Features
**uvm_code_gen** generates the following code:
  - VIPs (agent, interface, sequence, coverage)
  - top-level environment
    - testbench
    - env (scoreboard, VIP, coverage)
    - virtual sequence
  - run script

## 🚀 Usage
### Basic
```sh
./main.py examples/fifo/fifo_in.conf examples/fifo/fifo_out.conf
```

Generated files are in `./output`.

#### run simulation
  1. create `bin/dut_files.f`
  1. edit dut instantiation in `top/tb/top_th.sv`
  1. `cd bin` and `./run`

#### edit to your liking
  - VIP
    - clocking blocks in `vip/*/*_if.sv`
    - `do_drive()` in `vip/*/*_driver.sv`
    - `do_mon()` in `vip/*/*_monitor.sv`
  - TOP
    - `write_from_*()` in `top/top_scoreboard.sv`
    - `top/top_seq_lib.sv`

### Advanced
#### top_env_name
```sh
# top-level environment default name is "top"
./main.py examples/fifo/fifo_in.conf examples/fifo/fifo_out.conf

# top-level environment name is "fifo"
./main.py examples/fifo/fifo_in.conf examples/fifo/fifo_out.conf -t fifo
```

#### top_map
By default:
  - each VIP is instiated once
  - instance name is the name of the VIP

This can be changed using the `--top_map` option.
```sh
# multiple instances of the VIPs
./main.py examples/noc/*.conf --top_map examples/noc/top.map

# you can also refer to VIPs that are not defined by a config file:
#  - the top-level env/scoreboard/etc will be correctly generated
#  - the VIP directory won't be generated
./main.py --top_map examples/noc/top.map
```

#### has_master_and_slave
Adding `has_master_and_slave = 1` in the configuration file will
  - add `*_master_driver.sv` and `*_slave_driver.sv`
  - add `is_master` field in the VIP's config class and use it in the `*_agent.sv`
  - set `is_master` in the `top_config.sv` to 1 if the instance name matches **master**
  - add a **master** and **slave** instance by default (unless `--top_map` is used)

```sh
./main.py examples/handshake/handshake.conf
```

## 🚧 TODO
  - change seq name to something less generic ?
  - change convert2string() formatting ?
  - code formatting ?

## 🙏 Credits
The UVM code generation and coding guidelines are heavily inspired by [Doulos' easier_uvm](https://www.doulos.com/knowhow/systemverilog/uvm/easier-uvm/).  
Thanks a lot to all the contributors.
