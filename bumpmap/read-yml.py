import yaml

with open("ken-bumps.yml", "r") as orig:
    loaded = yaml.safe_load(orig)

connected = [(1, 22), # clock
             (5, 22), # reset
             (2, 15), # sertl_in_ready
             (4, 15), # sertl_clock
             (2, 17), # sertl_in_bits1
             (4, 17), # sertl_in_bits2
             (1, 16), # sertl_in_bits3
             (5, 16), # sertl_in_valid
             (2, 19), # sertl_out_bits3
             (4, 19), # sertl_out_valid
             (1, 18), # sertl_out_ready
             (5, 18), # sertl_in_bits0
             (4, 21), # sertl_out_bits0
             (1, 20), # sertl_out_bits1
             (5, 20), # sertl_out_bits2
             (5, 12), # uart_txd
             (1, 12), # uart_rxd
             (4, 13), # jtag_tck
             (2, 13), # jtag_tms
             (5, 14), # jtag_tdi
             (1, 14), # jtag_tdo
             ]

assignments = loaded["vlsi.inputs.bumps"]["assignments"]
print("vlsi.inputs.bumps.assignments: [")
tuples = []
for i, ass in enumerate(assignments):
    x = ass["x"]
    y = ass["y"]
    name = ass["name"]
    no_connect = "false"
    if name == "VCC":
        name = "vdd"
    elif name == "VSS":
        name = "vss"
    elif name == "VDD":
        name = "vdd"
    elif name == "VDDV":
        name = "vddv"
    elif name == "VDDH": # vddh and vvddv are the same
        name = "vddv"
    else:
        name = "bump_{}_{}_net".format(x, y)
        if (x, y) not in connected:
            no_connect = "true"
    tuples.append((x, y, name, no_connect))

tuples = sorted(tuples, key = lambda t : t[0] * 100 + t[1])
for (i, tup) in enumerate(tuples):
    x, y, name, no_connect = tup
    if i == len(assignments)-1:
        comma = ""
    else:
        comma = ","
    print("  {{x: {}, y: {}, name: {}, no_connect: {}}}{}".format(x, y, name, no_connect, comma))

print("]")
