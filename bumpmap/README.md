These files [came from this branch](https://bwrcrepo.eecs.berkeley.edu/kimsea8209/rtml-intech22-chipyard/-/tree/rtml-jerry/vlsi/specs).

- `ken-bumps.yml` was the bumpmap for the hyperscale chip with the 2 ChipTop's inside
- The `read-yml.py` script reads `ken-bumps.yml` and hacks it to create `rtml-bumps.yml`
  - `rtml-bumps.yml` is what we should reference for the chip bumps
- `rtml-design.yml` is the hammer yaml file for the chip, but it seems a bit stale. Shouldn't need to reference it.
- `C4 Bump map for UNI2 package.xlsx` contains the mappings from the chip bump (x, y) coordinate to the logical net name
  - **WARNING**: the (x, y) coordinates DO NOT correspond to the (column, row) coordinates in the spreadsheet!!!
- **Actually**, refer to [this sheet](https://docs.google.com/spreadsheets/d/1MSgKrY-m9DyHcFtSvew053FMCg2KrU9-J1SnmbLqwV8/edit?usp=sharing) which contains the clear and correct (x, y) to package signal name mapping
- Finally, the symbol for the UNI2 socket contains the mappings from the socket bumps to the logical net name. We can assume that the UNI2 socket footprint's pad names are correctly assigned to the symbol's pad names.

## Mapping

| (chip bump x, chip bump y) | Design signal name | Direction (from chip perspective) | Package/socket signal name |
| ---     | ---                   | ---     | ---             |
| (1, 12) | uart_rx               | input   | HSDIFF_16_N_Q3  |
| (1, 14) | jtag_tdo              | output  | HSDIFF_15_N_Q3  |
| (1, 16) | serial_tl_in\[3\]     | input   | HSDIFF_14_N_Q3  |
| (1, 18) | serial_tl_out_ready   | input   | HSDIFF_13_N_Q3  |
| (1, 20) | serial_tl_out\[1\]    | output  | HSDIFF_12_N_Q3  |
| (1, 22) | clock                 | input   | HSDIFF_11_N_Q3  |
| (2, 13) | jtag_tms              | input   | HSDIFF_16_P_Q3  |
| (2, 15) | serial_tl_in_ready    | output  | HSDIFF_15_P_Q3  |
| (2, 17) | serial_tl_in\[1\]     | input   | HSDIFF_14_P_Q3  |
| (2, 19) | serial_tl_out\[3\]    | output  | HSDIFF_13_P_Q3  |
| (2, 23) | pll_refclk            | input   | HSDIFF_11_P_Q3  |
| (4, 13) | jtag_tck              | input   | HSDIFF_7_P_Q3   |
| (4, 15) | serial_tl_clock       | input   | HSDIFF_6_P_Q3   |
| (4, 17) | serial_tl_in\[2\]     | input   | HSDIFF_5_P_Q3   |
| (4, 19) | serial_tl_out_valid   | output  | HSDIFF_4_P_Q3   |
| (4, 21) | serial_tl_out\[0\]    | output  | HSDIFF_3_P_Q3   |
| (5, 12) | uart_tx               | output  | HSDIFF_7_N_Q3   |
| (5, 14) | jtag_tdi              | input   | HSDIFF_6_N_Q3   |
| (5, 16) | serial_tl_in_valid    | input   | HSDIFF_5_N_Q3   |
| (5, 18) | serial_tl_in\[0\]     | input   | HSDIFF_4_N_Q3   |
| (5, 20) | serial_tl_out\[2\]    | output  | HSDIFF_3_N_Q3   |
| (5, 22) | reset                 | input   | HSDIFF_2_N_Q3   |
