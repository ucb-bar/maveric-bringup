These files [came from this branch](https://bwrcrepo.eecs.berkeley.edu/kimsea8209/rtml-intech22-chipyard/-/tree/rtml-jerry/vlsi/specs).

## Files

- `ken-bumps.yml` was the bumpmap for the hyperscale chip with the 2 ChipTop's inside
- The `read-yml.py` script reads `ken-bumps.yml` and hacks it to create `rtml-bumps.yml`
  - `rtml-bumps.yml` is what we should reference for the chip bumps
- `rtml-design.yml` is the hammer yaml file for the chip, but it seems a bit stale. Shouldn't need to reference it.
- `C4 Bump map for UNI2 package.xlsx` contains the mappings from the chip bump (x, y) coordinate to the logical net name
  - **WARNING**: the (x, y) coordinates DO NOT correspond to the (column, row) coordinates in the spreadsheet!!!
- **Actually**, refer to [this sheet](https://docs.google.com/spreadsheets/d/1MSgKrY-m9DyHcFtSvew053FMCg2KrU9-J1SnmbLqwV8/edit?usp=sharing) (`Hyperscale 4x4 Package.xlsx`) which contains the clear and correct chip bump (x, y) to signal name mapping

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

## Symbol Validation

Now let's discuss the physical bump layout.

For the C4 bumps on the chip, the quadrants are as such (bumps on top):

| Q4 | Q2 |
| -- | -- |
| Q3 | Q1 |

Then, this chip is flipped onto the package on the vertical-axis so the bumps look like this (package balls on bottom):

| Q2 | Q4 |
| -- | -- |
| Q1 | Q3 |

This is the layout assumed by the `UNI2 ball map.csv` file, which we use to validate the net name to package/socket coordinate mapping.
CRITICALLY, the origin is at the center of the package and the positive y-axis goes up and the positive x-axis goes right.

Then, the package is rotated by 180 degrees so that Q3 appears in the upper right quadrant.
This requires a coordinate transformation (x, y) -> (new x, new y):

- (+, +) → (-, -)
- (+, -) → (-, +)
- (-, +) → (+, -)
- (-, -) → (+, +)
- This is just sign inversion

| Q3 | Q1 |
| -- | -- |
| Q4 | Q2 |

One note: the balls on the socket are shifted right by 0.375mm relative to the package center origin, so we must compensate for that when parsing the socket footprint.
CRITICALLY, the socket footprint has a different coordinate axis! The positive y-axis goes down and the positive x-axis goes right.
This requires another coordinate transformation (x, y) -> (new x, new y):

- (+, +) → (+, -)
- (+, -) → (+, +)
- (-, +) → (-, -)
- (-, -) → (-, +)
- This is just flipping the sign of the y coordinate

At this point, we have the (x, y) location to net name mapping which we check against the footprint + symbol.

```
python -m venv venv
source venv/bin/activate
pip install sexpdata
./extract_pads --footprint ../maveric-board/maveric-parts.pretty/BGA-1733-.92-47.725x47.725.kicad_mod --symbol-name TESTCHIP_UNI2 --symbol-lib ../maveric-board/maveric-parts.kicad_sym --reference-csv UNI2\ ball\ map.csv
```

This script does the symbol validation.
It parses the socket footprint to get the pad positions (in mm) and pad coordinate (e.g. AN13).
It parses the symbol to get the mapping of pad coordinate to net name (HSDIFF...).
It parses the reference CSV to get the mapping of net name to pad position (bump coordinate in mm).
It checks that everything matches up. And indeed everything matches up.
