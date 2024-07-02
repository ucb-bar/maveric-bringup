# Maveric Bringup

## Test Plan

### FPGA Devboard

- Things to consider: cost, FPGA type, host interface, DRAM, connector + voltages, form factor
- [Xilinx VCU118](https://www.xilinx.com/products/boards-and-kits/vcu118.html)
  - $9k
  - Virtex Ultrascale+
  - USB-UART / PCIe with riser
  - 2x 2.5 Gib DDR4
  - FMC-HPC (ASP-134486-01), VADJ = 1.8V by default, can go down to 1.2V if FMC EEPROM is programmed or if system controller is overridden (intricate, but doable)
  - Large PCIe card
- [Opal Kelly XEM7350](https://opalkelly.com/products/xem7350/)
  - $1.5k
  - Kintex 7
  - USB3 with special RTL + drivers (Opal Kelly FrontPanel) with 340 MiB/s bandwidth
  - 512 MiB DDR3
  - FMC-HPC (-K160T part) (ASP-134486-01) (mates with ASP-134488-01), (34 (LA, Vadj) + 24 (HA, Vadj) + 22 (HB, Vio) = 80 IO pins), Vadj easy to set to 1.2V permanently, Vio comes from FMC_VIO_B_M2C (which can just be shorted to Vadj on the mezzanine)
  - Pretty small card
- [Digilent Nexys Video](https://digilent.com/shop/nexys-video-artix-7-fpga-trainer-board-for-multimedia-applications/)
  - $550
  - Artix 7
  - USB-UART / Ethernet / FT2232 (FTDI USB-FIFO chip, kind of an old part with iffy drivers)
  - 512 MiB DDR3
  - FMC-LPC (ASP-134603-01), 34x2 pins, Vadj set to 1.2V by default, easy

#### Mechanical Sketch

- [XEM7350 Mechanical Drawing](https://docs.opalkelly.com/wp-content/uploads/2022/05/XEM7350-MechanicalDrawing.pdf)
  - 4x standoffs for the FPGA devboard that exceed 6.5mm in height, 2.70mm hole diameter (use M2 standoff kit, M2 has clearance hole diameter of 2.6mm)
  - 2x standoffs for the chip motherboard that are likely around 18.5mm (will use same hole diameter)

### Chip Signals + Debug

[Bump map](https://bwrcrepo.eecs.berkeley.edu/kimsea8209/rtml-intech22-chipyard/-/blob/rtml-jerry/vlsi/specs/rtml-bumps.yml?ref_type=heads) is saved in the `bumpmap` folder.
See the `README.md` in that folder for details.

#### Signals

- **JTAG**
  - Directly place the JTAG header on the motherboard. Don't daisy chain chip JTAG to FMC JTAG. Don't pass JTAG signals through FMC.
  - Use [this JTAG debugger](https://www.olimex.com/Products/ARM/JTAG/ARM-USB-OCD-HL/) (**-HL variant** works down to 0.65V)
    - [Digikey link](https://www.digikey.com/en/products/detail/olimex-ltd/ARM-USB-OCD-HL/21662466) ($58.79)
  - Use a USB optoisolator if we're scared
    - [Olimex link](https://www.olimex.com/Products/USB-Modules/USB-ISO/)
  - Standard [20-pin ARM JTAG header](https://developer.arm.com/documentation/101416/0100/Hardware-Description/Target-Interfaces/ARM-Standard-JTAG)
    - 2 rows × 10 pins at 0.1" step
    - [This will do, Digikey link](https://www.digikey.com/en/products/detail/sullins-connector-solutions/SBH11-PBPC-D10-ST-BK/1990065)
    - [Another Molex alternative that's much more expensive for some reason](https://www.digikey.com/en/products/detail/molex/0702462002/760185)
- **UART**
  1. Wire through FMC if we want to use the FPGA to drive chip UART
  2. Break out to headers to jump into the [Digilent Pmod USBUART](https://digilent.com/reference/pmod/pmodusbuart/reference-manual?redirect=1)
    - Requires level translation from 1.2V to 3.3V
  - Use jumpers to select between the 1) and 2) options for interacting with the chip via UART
    - Use standard 0.1" pitch 3x1 male headers and a shorting jumper for each wire (RX/TX)
    - [Shorting jumper - Digikey](https://www.digikey.com/en/products/detail/sullins-connector-solutions/QPC02SXGN-RC/2618262)
- **Serial TL**
  - Break out every signal (4 data + 1 valid + 1 ready = 6 pins/direction, 12+1 clock) to header pins via 0 Ohm resistor
  - Length match all signals roughly, within 10 mm
  - Make sure all signals land in same FPGA IO bank and land on pins with roughly the same [routing length on the devboard](https://pins.opalkelly.com/pin_list/XEM7350)
- **Chip reset**
  - Reset is active high. It is asynchronous. It is internally synchronized to the core clock domain on the falling reset edge.
  - Break out reset to header pin
  - ~~Drive a LED to indicate reset state with driver FET (make sure V_{gs,max} << 1.2V)~~ (bad idea to add more load on the reset net)

#### Clocking

- **Serial TL clock**
  - Always driven from FPGA FMC along with the rest of serial TL signals
  - No impedance control, but serial TL traces are roughly length matched (yeah I know this is overkill)
- **Core clock**
  - Can be driven by:
    1. FPGA via a regular GPIO pin over FMC
    2. External clock generator
  - Trace should have 50 Ohm impedance. Use SMAs to jump the FPGA clock to the chip clock and to receive the external clock (3x SMA total).
  - [Use shunt 50 Ohm termination near the chip clock pin](https://electronics.stackexchange.com/questions/646896/cannot-trigger-digital-logic-because-half-of-source-voltage-is-lost-in-impedance)
    - This works fine for the FPGA clock driver since it has low-Z output impedance. It will drive rail-to-rail 1.2Vpp at the chip.
    - This is a problem for the external clock generator since it has 50 Ohm series output impedance. It will drive 0.6Vpp at the chip nominally, so it will have to drive 2.4Vpp at the source for the chip to see 1.2Vpp.
- **PLL refclk**
  - Only comes from external clock generator with 50 Ohm driving impedance
  - Since it drives a high-Z IO cell, no termination is required, and Vpp on the generator should be set to 1.2V

#### Power

- Chip has 2 power inputs (VDD = core, VDDV = IO)
- VDDV and VDD can come from:
  1. External supply via banana plug (for current measurement)
  2. VADJ from FMC (nominally 1.2V) ()
  - Jumpers are used to select between 1) and 2)
- PCB considerations
  - Use 2 separate layers for VDD and VDDV so we can via directly to them from anywhere
  - Use 2 separate layers for GND
  - Front and back copper used for signal routing + ground pour
  - Route 3V3 FMC supply on top copper (we aren't using the other FMC supplies like 3V3AUX and 12V)
- Short all grounds together (FMC + banana plug ground)
- Headers for Vadj, VDD, GND, all FMC provided supplies

##### Decap

- Same strategy as hyperscale chip
- 10uF caps, 0603, place on backside of socket. Be wary of backside KOZ which are quite unusual.
- Use 100uF caps on VDD, VDDV, 3V3 supplies
- Use 10uF caps for decap near level shifters

### Chip Board to FPGA Connector

- Just use FMC, don't bother with adding the FMC EEPROM, loop FMC JTAG on the board with no daisy chaining, N/C FMC I2C
  - [FMC FAQ](https://www.vita.com/FMC-FAQ)
    - Attaching a LPC mezzanine to a HPC carrier is just fine as long as none of the HPC pins are used on the mezzanine
  - [Samtec's VITA 57.1 part picker](https://www.samtec.com/standards/vita/fmc/)
    - We can choose any HPC/LPC connector with/without leaded solder depending on what connectors are [in stock at JLCPCB](https://jlcpcb.com/parts/all-electronic-components)
- FMC powergood (C2M)
  - Add LED indicator + header probe point

## Schematic Review

- [x] Make sure all the chip IOs are represented and properly connected
  - ~~We seem to have used HSDIFF Q4 bumps (Hyperscale chip used HSDIFF Q3 for chip A and HSDIFF Q4 for chip B)~~
  - There are no clock taps, there isn't a `custom_boot` pin either
  - OH NO, I did make a mistake here. Refer to [this spreadsheet](https://docs.google.com/spreadsheets/d/1MSgKrY-m9DyHcFtSvew053FMCg2KrU9-J1SnmbLqwV8/edit#gid=0) for the correct mappings
- [x] Check clocking
  - [x] Is the PLL refclk terminated on-chip?
- [x] Verify UART directionality
- [x] Make sure power topology is correct
- [x] Make sure all debug functionality is available
- [x] Make sure decap is sufficient
- [x] Does the stackup look reasonable?
- [x] Is everything sane mechanically?

### Notes from Review

- [x] Add a 3 pin header to select reset coming from either FPGA or a button
- [x] 6 pin female header for PMOD USBUART
- [x] Add some more ground probe points (header pin + loop pin things) (4x around the PCB)
- [x] bring in JTAG signals onto the FPGA too via FMC
- [x] fix up the signal name mappings on the schematic
- [x] allocate one more layer for signal routing, combine VDD/VDDV into one layer
- [x] add holes next to FMC connector
- Length matching is unnecessary
- Support UART to Pmod through FPGA and with board headers directly
- Termination shouldn't cause any issues
- Make sure you have lots of test points, lots of ground test points too, make sure every probe for a signal has a short path to ground nearby
- Make sure the JTAG clock is exposed on a header pin
- Make sure you have standoffs near the FMC connector

## PCB CAD

### Considerations

- [Hyperscale test plan slides](https://docs.google.com/presentation/d/1U_Xe0r3WAxrghMTiEDUyeD21PqD4RekB/edit#slide=id.g2c498c81fbe_0_5S)
  - Contains some clocking and PLL and reset notes
- Plan is to use JLCPCB with 6+ layer 2mm board, 2U" ENIG, epoxy filled vias (if via-in-pad is required), 0.15mm min vias, uncontrolled impedance
  - Ideally I can relax the min via diameter, but it may not be possible with the fine BGA pitch. Via-in-pad might be necessary to make routing doable with few layers. Increase layers if required: maybe we can get away with 4 even.
  - Plan is to also do assembly with JLCPCB and get just fully assembled boards. I have verified all parts are in stock and all symbols on schematic are annotated with their 'JLCPCB Part #'.
- [JLCPCB PCB Design Rules](https://jlcpcb.com/capabilities/pcb-capabilities)
  - min 0.25mm BGA pads - OK
  - hole to hole clearance 0.5mm - OK
  - 0.09mm min trace width, 0.09 min trace spacing - seems sufficient for BGA escape
- [JLCPCB BGA Design Notes](https://jlcpcb.com/help/article/243-BGA-Design-Guidelines---PCB-Layout-Recommendations-for-BGA-packages)
  - 0.10mm min trace to BGA pad spacing
  - Everything still seems good enough
- [JLCPCB via-in-pad notes](https://jlcpcb.com/help/article/122-Via-Covering:-Tented,-Untented,-Plugged,-Epoxy-Filled-and-Copper-epoxy-filled)
  - 6+ layer boards come with epoxy filled vias for free! Pricing is insanely cheap for via-in-pad. Vias must be smaller than 0.5mm for full coverage.
- Someone has drafted [KiCad DRC rules for JLCPCB](https://gist.github.com/darkxst/f713268e5469645425eed40115fb8b49?permalink_comment_id=4818217) which I can use for reference
- Someone has tried to [escape a 0.5mm pitch BGA](https://www.eevblog.com/forum/altium/altium-jlcpcb-and-0-65mm-bga/) and it seems fine - just need to relax some design rules and make sure the hole clearance rule is specified correctly
- Another [via-in-pad attempt for 0.5mm pitch BGA](https://electronics.stackexchange.com/questions/676149/how-to-escape-0-5mm-ball-grid-array-pins) - seems possible with via-in-pad

### Stackup

- [JLCPCB Stackups](https://jlcpcb.com/impedance)
- 6 layer, 2mm thickness, 1oz outer copper weight, 0.5oz inner copper weight
- **Chosen Stackup**: JLC06201H-3313

| Layer     | Material Type | Thickness | Purpose               |
| ---       | ---           | ---       | ---                   |
| F.Cu      | Copper        | 0.035mm   | Signal, 3V3 (GND pour)|
| Prepreg   | 3313*1        | 0.0994mm  | -                     |
| In1.Cu    | Copper        | 0.0152mm  | GND                   |
| Core      | Core          | 0.7mm     | -                     |
| In2.Cu    | Copper        | 0.0152mm  | VDD, VDDV             |
| Prepreg   | 7628*1        | 0.2028mm  | -                     |
| In3.Cu    | Copper        | 0.0152mm  | Signal (GND pour)     |
| Core      | Core          | 0.7mm     | -                     |
| In4.Cu    | Copper        | 0.0152mm  | GND                   |
| Prepreg   | 3313*1        | 0.0994mm  | -                     |
| B.Cu      | Copper        | 0.035mm   | Signal (GND pour)     |

- The stackup looks like (F.Cu, In1.Cu) | (In2.Cu, In3.Cu) | (In4.Cu, B.Cu) (i.e. 2-2-2)
- The first and third pairs are strongly coupled and the second pair has more separation

### Controlled Impedance Traces

- [JLCPCB Controlled Impedance Calculator](https://jlcpcb.com/pcb-impedance-calculator)
  - With the above stackup for 50 Ohm single-ended (non coplanar) (microstrip) on top copper with ground on In1.Cu
  - Trace width: **6.16 mils**

### Design Notes

#### UNI2 Socket

- Unit A-D: HSDIFF_{1-18}_{Q1-4}
- Unit E-H: IODIFF_{1-41}_{Q1-4}
- Unit I/J: Q1_{VDD, VDDV/VDDH}
- Unit K/L: Q2_{VDD, VDDV/VDDH}
- Unit M/N: Q3_{VDD, VDDV/VDDH}
- Unit O/P: Q4_{VDD, VDDV/VDDH}
- Unit Q-Y: VSS

#### FMC Terminal Selection

Possible parts [we can choose from](https://www.samtec.com/standards/vita/fmc/).
I would avoid tin-lead parts just because JLCPCB uses non-leaded solderpaste, and I'm unsure if reflow will work properly.
Also noting stock from JLCPCB.

- 8.5mm, lead-free, HPC: ASP-134602-01
    - 0 stock, $24.63 / part
- 8.5mm, lead-free, LPC: ASP-134606-01
    - 0 stock, $22.24 / part
- 10mm, lead-free, HPC: ASP-134488-01
    - 0 stock, listed as unavailable
- 10mm, lead-free, LPC: ASP-134604-01
    - 9 stock, $15.30 / part, still requires pre-order

- C2M = FPGA to motherboard = connector outputs
- M2C = motherboard to FPGA = connector inputs

#### FMC Pin to Socket Pin Mapping

- Use [XEM7350 Pins](https://pins.opalkelly.com/pin_list/XEM7350#) as reference for length matching. Keep all pins on the same FPGA IO bank ideally. We can choose from IO banks 15 or 16. We should keep to trace lengths (FMC socket to FPGA) around 80mm (78-82mm).

| Signal                    | FMC Net Name  | FMC Pin | Trace Length on XEM7350 (mm)  | FPGA IO Bank  | FPGA Pin  | Notes |
| ---                       | ---           | ---     | ---                           | ---           | ---       | ---   |
| serial_tl_clock           | LA_00_P_CC    | G6      | 79.41                         | 15            | H17       |       |
| serial_tl_in_ready        | LA_03_P       | G9      | 79.53                         | 15            | A18       |       |
| serial_tl_in_valid        | LA_03_N       | G10     | 79.51                         | 15            | A19       |       |
| serial_tl_in_bits\[0\]    | LA_06_P       | C10     | 79.61                         | 15            | C19       |       |
| serial_tl_in_bits\[1\]    | LA_06_N       | C11     | 79.65                         | 15            | B19       |       |
| serial_tl_in_bits\[2\]    | LA_10_P       | C14     | 79.66                         | 15            | B17       |       |
| serial_tl_in_bits\[3\]    | LA_10_N       | C15     | 79.65                         | 15            | A17       |       |
| serial_tl_out_ready       | LA_05_P       | D11     | 78.61                         | 15            | C17       |       |
| serial_tl_out_valid       | LA_05_N       | D12     | 78.63                         | 15            | C18       |       |
| serial_tl_out_bits\[0\]   | LA_09_P       | D14     | 79.63                         | 15            | L19       |       |
| serial_tl_out_bits\[1\]   | LA_09_N       | D15     | 79.63                         | 15            | L20       |       |
| serial_tl_out_bits\[2\]   | LA_15_P       | H19     | 79.79                         | 15            | K16       |       |
| serial_tl_out_bits\[3\]   | LA_15_N       | H20     | 79.74                         | 15            | K17       |       |
| clock                     | LA_01_P_CC    | D8      | 79.68                         | 15            | G17       | via SMA cable jumper |
| reset                     | LA_21_P       | H25     | 80.45                         | 15            | G15       |       |
| uart_rx                   | LA_02_P       | H7      | 83.66                         | 15            | G19       | via selection jumper |
| uart_tx                   | LA_02_N       | H8      | 83.65                         | 15            | F20       | via selection jumper |
| fpga_refclk               | CLK0_M2C_P    | H4      | 82.74                         | 15            | E18       | for locking FPGA PLL to external clock source |
| fpga_gpio\[0\]            | LA_14_P       | C18     | 77.23                         | 15            | H16       | to header + LED |
| fpga_gpio\[1\]            | LA_14_N       | C19     | 77.24                         | 15            | G16       | to header + LED |
| fpga_gpio\[2\]            | LA_27_P       | C26     | 77.01                         | 16            | D9        | to header + LED |
| fpga_gpio\[3\]            | LA_27_N       | C27     | 77.10                         | 16            | D8        | to header + LED |
| jtag_tdi                  | LA_23_P       | D23     | 81.08                         | 16            | F14       |       |
| jtag_tdo                  | LA_23_N       | D24     | 81.09                         | 16            | F13       |       |
| jtag_tms                  | LA_26_P       | D26     | 79.86                         | 16            | C9        |       |
| jtag_tck                  | LA_26_N       | D27     | 79.82                         | 16            | B9        |       |

#### Extra Things to Buy

- Olimex JTAG debugger
- PMOD USB-UART
- A set of jumper cables (male to female)
- M2 standoff kit
- Header pin shorting jumpers
- FPGA devboard

#### Assembly Notes

- DNP the UNI2 socket
- Do not wave solder any through-hole components, hand-solder instead

## Tasks

- [x] Check FMC connector footprint [d:6/10]
  - [x] Dimension check: All dimensions check out, I drew some additional things on the silkscreen
  - [x] Solderpaste check: Specifically check solderpaste layer expansion. Pad 25 mils, soldermask expansion 4 mils (default, not that critical), solder paste 35 mils! So yes I adjusted the solder paste clearance.
- [x] Add FMC LPC symbol [d:6/10]
- [x] Wire FMC connector on schematic [d:6/10]
  - [x] Connect power supplies to globals and hierarchical outputs
  - [x] Add FPGA GPIOs
  - [x] Connect various things to GND / PWR
  - [x] Connect chip signals to FMC. Pin planning: want roughly equal delays on all serialtl nets.
  - [x] Add GND/VADJ drivers for unused FMC nets
    - Just to make sure FPGA can read things off the FMC connector
- [x] Add debug headers [d:6/10]
  - [x] 20pin header symbol + footprint + part
  - [x] 3pin header symbol + footprint + part
  - [x] 0 Ohm resistor symbol + footprint + part
  - [x] Add serialTL debug via 0Ohm resistors
  - [x] Add GPIO debug (direct)
- [x] Add terminal blocks for external supplies
  - [x] Add black banana plug symbol + footprint + part
  - [x] Add red banana plug symbol + footprint + part
- [x] Split FPGA and external supplies via jumper [d:6/12]
- [x] Add power domain probe points [d:6/12]
- [x] Add UART headers + jumpers [d:6/12]
- [x] Add UART level shifter [d:6/12]
- [x] Add JTAG headers
- [x] Add JLCPCB part for chip 10u decap
- [x] Add PG FPGA GPIO LEDs [d:6/14]
  - The LEDs on the hyperscale board seem like a waste. Seeing an 'on' LED for VDD doesn't prove anything lol.
  - I only care about the GPIOs and PG from the carrier to mezzanine (which are all slow signals)
  - No need to add an LED on the reset net, we already have a probe point which is sufficient (adding a LED will add NMOS gate cap and shunt resistor, which could retard the rise/fall time)
  - [x] Pick out all the components (2 resistors, MOSFET, LED)
  - [x] LED footprint + 3D
  - [x] MOSFET footprint + 3D
  - [x] Pick current limit resistor
- [x] Add clock nets with impedance control [d:6/14]
  - Fpga output impedance is uncontrolled (very low) impedance lvcmos12 IO standard
  - Terminate with shunt 50 Ohm that the Fpga can use
  - The clock generator will have to output 2x Vpp swing
  - [x] Sketch out clocking strategy
- [x] Add extra trigger refclk for the fpga pll to lock serial tl clock to core clock (if needed to mitigate async crossing issues) [d:6/16]
- [x] Add and check UNI2 socket footprint [d:6/16]
  - Check non-plated through holes, check pad spacing and diameter, check centerline
- [x] Add decap on power rails (VDD, VDDV, core + IO power domains, large decap) [d:6/16]
  - [x] Add decap on 3v3 rail too
  - [x] Add decap around level shifters too
- [x] Sketch out mechanical stuff of fpga devboard and chip board with fmc mating, describe standoffs + positions + hole diameters [d:6/16]
- [x] Add probe for FMC powergood (PG) [d:6/16]
- [x] Check that FMC powergood is actually at VADJ level (1.2V) [d:6/16]
  - Yes this seems to be the case (from checking ZC706 schematic)
- ~~[ ] Add clock probe pads~~
  - ???: Not a good idea when using shunt termination

### Final Re-Checks

- [x] Footprint and symbol finalization [d:6/16]
  - [x] Define custom MOSFET symbol to make sure pin numbers line up (for led driver)
  - [x] Define a custom LED symbol to make sure pin numbers line up with cathode/anode (for led driver)
- [x] Redo check of FMC symbol (pin name to pin coordinate mapping) [d:6/16]
- [x] Check chip IOs are represented and properly connected [d:6/16]
  - Against the Hyperscale schematic

### Post-Review Fixes

- [x] Fix chip IO mappings [d:6/19]
  - Refer to [this spreadsheet](https://docs.google.com/spreadsheets/d/1MSgKrY-m9DyHcFtSvew053FMCg2KrU9-J1SnmbLqwV8/edit#gid=0)
  - Delete all the garbage docs that confuse everyone
- [x] Import socket 3d model [d:6/21]
- [x] Fix reset circuit [d:6/21]
    - Add 3-pin header for reset selection + button
    - For the button path: pull down (1k || 100nF), button will pull reset high to VDDV
    - For the FPGA path: FPGA drives reset directly via FMC
    - [x] Add the switch 3d model + footprint
- [x] Add a 6-pin female header for plugging in the USBUART Pmod [d:6/19]
- [x] Add ground probe points around the PCB [d:6/19]
  - [x] Add 4x hook-style probes to GND around the board
  - [x] Sprinkle ground pins near every signal that can be probed
    - Just make sure every probe point has a ground pin nearby
- [x] Replace the supply probes header pins with hook-style probes [d:6/19]
- [x] Modify stackup to use one more layer for signal routing [d:6/19]
- [x] Bring JTAG signals onto the FPGA via FMC too [d:6/19]
- [x] Add mounting holes next to FMC connector [d:6/19]
- [x] Reexamine extended parts [d:6/21]
    - Try to convert to JLCPCB Basic parts if possible
    - There are 12 extended parts left
      - For SMT: level shifter, switch button, SMT testpoint, LED, FMC terminal, LED MOSFET driver
      - For through-hole (hand-soldered): black banana plug, red banana plug, 3 pin header, SMA connector, 20 pin header, 6 pin female header right-angle
      - 12 x \$2/extended part = \$24 assembly part fee
- [x] Reimport all symbols [d:6/21]
- [x] Reannotate schematic and push to layout [d:6/21]
- [x] Validate socket symbol [d:6/23]
  - Validate all the package coordinate to logical signal net mappings from the Intel schematic
  - I already found one error
  - We sent a mail to Brian casper on 6/21, let's see. I don't trust anything hand drawn unless I have the source.
  - Turns out there is no error. Assuming that `UNI2 ball map.csv` is golden, then the footprint + symbol are also perfect.

## Layout

### Setup

- [x] JLCPCB stackup + layer assignments [d:6/16]
- [x] JLCPCB constraints and design rules [d:6/16]
- [x] Import from schematic + placement [d:6/16]
- [x] Sketch edge cuts + standoff holes [d:6/16]
- [x] Verify 3d model placement of FMC [d:6/22]
  - FMC terminal footprint: https://suddendocs.samtec.com/prints/seam-xx-xx.x-xx-xx-x-a-xx-footprint.pdf
  - FMC terminal mechanical drawing: https://suddendocs.samtec.com/prints/seam-xx-xx.x-xxx-xx-x-a-xx-k-xr-mkt.pdf
  - Indeed the single tab is on the side of pin 1 and the double tabs are on the side of pin 40
- [x] Verify rotation and mounting and holes of FMC [d:6/22]
  - The mounting holes are biased towards the later letters as expected. Things look right.
- [x] Reimport from schematic [d:6/22]

### Routing

- [x] Route 3.3V [d:6/22]
- [x] Route VADJ
- [x] Route VDD_EXT
- [x] Route VDDV_EXT
- [x] Route all 50Ohm traces
- [x] Route all UART circuits
- [x] Route all JTAG pins
- [x] Route chip signal traces to FMC
- [x] Rip up 0.15mm vias [d:7/1]
- [x] Place and route decap [d:6/29]
- [x] Place Q3 vias [d:6/29]
- [x] Place all power/gnd vias [d:6/29]
- [ ] Route chip signal probes via jumpers [d:6/29]
- [ ] Pour GND and route [d:6/29]
- [ ] Pour VDD + VDDV [d:6/29]

### Finalization

- [x] Add JLC silk
- [ ] Add stiching vias for ground planes
- [ ] Add board name + chip + people silk
- [ ] Add fun silk
- [ ] Clean all silks
  - Placement, overlap, and text
- [ ] Check DRC and connectivity
