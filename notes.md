# RTML Bringup

## Strategy

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

- https://docs.opalkelly.com/wp-content/uploads/2022/05/XEM7350-MechanicalDrawing.pdf
  - 4x standoffs for the FPGA devboard that exceed 6.5mm in height, 2.70mm hole diameter (use M2 standoff kit, M2 has clearance hole diameter of 2.6mm)
  - 2x standoffs for the chip motherboard that are likely around 18.5mm (will use same hole diameter)

### Chip Signals + Debug

[Bump map](https://bwrcrepo.eecs.berkeley.edu/kimsea8209/rtml-intech22-chipyard/-/blob/rtml-jerry/vlsi/specs/rtml-bumps.yml?ref_type=heads) is saved in the `bumpmap` folder. I still have some questions.

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
- **DDR DFI**
  - Input pins to the chip should be grounded and output pins should be left floating
  - Not going to expose this interface on this board, it's not worth it
- **UART**
  1. Wire through FMC if we want to use the FPGA to drive chip UART
  2. Break out to headers for [FTDI USB-UART cable](https://www.sparkfun.com/products/9718)
    - Break out into headers that directly plug into the cable socket
    - Requires level translation from 1.2V to 3.3/5V
  - Jumpers to select between the 1) and 2) options for interacting with the chip via UART
    - Use standard 0.1" pitch 3x1 male headers and a shorting jumper for each wire (RX/TX)
    - [Shorting jumper - Digikey](https://www.digikey.com/en/products/detail/sullins-connector-solutions/QPC02SXGN-RC/2618262)
- **Serial TL**
  - Break out every signal (4 data + 1 valid = 5 pins/direction, 10+1 clock) to header pins via 0 Ohm resistor
  - Length match all signals roughly, within ~5-10 mm
  - Make sure all signals land in same FPGA IO bank and land on pins with roughly the same [routing length on the devboard](https://pins.opalkelly.com/pin_list/XEM7350)
- **Chip reset**
  - **TODO**: Check if reset is active low or high. I suspect active high as usual.
  - Breakout reset to header pin
  - Drive a LED to indicate reset state with driver FET (make sure V_{gs,max} << 1.2V)

#### Clocking

- Serial TL clock: always driven from FPGA FMC along with rest of serial TL signals
- Core clock + PLL refclk
  - Check termination (?), I think both should be regular high-impedance CMOS
  - FMC pins from FPGA drive SMA female port
  - Another SMA female port drives the chip
  - Short SMA bridge cable can be used for FPGA clock driving, otherwise use bench clock generator
  - Controlled impedance and 50 Ohm termination is unnecessary - we are driving high-Z inputs anyways so max frequency will be quite low

#### Power

- Chip has 2 power inputs (VDD = core, VDDH = IO)
- VDDH driven by Vadj
  - There should be a VDDH moat we can flood on the power plane
- VDD driven by banana plug input from bench supply
  - There will be a core VDD area under the socket we can flood
- GND is shared among everything, also driven by banana plug input
  - Short all grounds together, uniform flood plane
- FMC provides 3.3V, 5V, and 12V supplies, which we won't use for anything except driving LEDs
- **TODO**: check if there is any issue with driving the IO and core with different supplies
  - Perhaps provide mode to short VDD with Vadj (but this is risky - we lose current limiter)
- Headers for Vadj, VDD, GND, all FMC provided supplies

### Decap

- Same strategy as hyperscale chip
- 10uF caps, 0603, place on backside of socket. Be wary of backside KOZ which are quite unusual.

### Chip Board to FPGA Connector

- Just use FMC, don't bother with adding the FMC EEPROM, loop FMC I2C and JTAG on the board with no daisy chaining
  - [FMC FAQ](https://www.vita.com/FMC-FAQ)
    - Attaching a LPC mezzanine to a HPC carrier is just fine as long as none of the HPC pins are used on the mezzanine (this is likely doable for us)
  - [Samtec's VITA 57.1 part picker](https://www.samtec.com/standards/vita/fmc/)
    - We can choose any HPC/LPC connector with/without leaded solder depending on what connectors are [in stock at JLCPCB](https://jlcpcb.com/parts/all-electronic-components)
- FMC powergood (C2M)
  - Add LED with driver FET
  - Add header probe

## PCB CAD

### Considerations

- [Hyperscale test plan slides](https://docs.google.com/presentation/d/1U_Xe0r3WAxrghMTiEDUyeD21PqD4RekB/edit#slide=id.g2c498c81fbe_0_5S)
  - Contains some clocking and PLL and reset notes
- Plan is to use JLCPCB with 6+ layer 2mm board, 2U" ENIG, epoxy filled vias (if via-in-pad is required), 0.15mm min vias, uncontrolled impedance
  - Ideally I can relax the min via diameter, but it may not be possible with the fine BGA pitch. Via-in-pad might be necessary to make routing doable with few layers. Increase layers if required: maybe we can get away with 4 even.
  - Plan is to also do assembly with JLCPCB and get just fully assembled boards. Might need to special order FMC terminals, but otherwise OK
- [JLCPCB PCB Design Rules](https://jlcpcb.com/capabilities/pcb-capabilities)
  - min 0.25mm BGA pads - OK
  - hole to hole clearance 0.5mm - OK
  - 0.09mm min trace width, 0.09 min trace spacing - seems sufficient for BGA escape
  - Everything looks good enough, no need for fancy board house
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
- [JLCPCB Controlled Impedance Calculator](https://jlcpcb.com/pcb-impedance-calculator)
  - Just match the stackup in the previous link with the one here and it will give you a trace width for a single-ended non-coplanar trace (for the PLL refclk)
