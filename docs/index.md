# Welcome to TangCore Documentation

TangCore is a comprehensive FPGA gaming distribution that brings classic gaming systems to Sipeed Tang FPGA boards. It combines multiple high-quality gaming cores into a single package with an easy-to-use menu system.

## Quick Links

- [Installation Guide](user-guide/installation.md)
- [Troubleshooting](user-guide/troubleshooting.md)
- [Developer Guide](dev-guide/architecture.md)

## Supported Systems

- **NESTang** - Nintendo Entertainment System
- **SNESTang** - Super Nintendo Entertainment System
- **GBATang** - Game Boy Advance
- **MDTang** - Sega Genesis/Mega Drive
- **SMSTang** - Sega Master System

## How TangCore Works

A TangCore board has two chips working together: a **BL616 MCU** (the "system manager") and a **Gowin FPGA** (the console itself).

1. **Power on**: the BL616 runs the TangCore firmware. It reads `cores/<your_board>/monitor.bin` from the SD card or USB drive, and programs the FPGA with it over JTAG. This is the "menu core" and takes about 5-7 seconds. If a core file cannot be found on the drive, the menu shows **N/A** for that system.
2. **Launching a game**: when you pick a ROM in the menu, the BL616 re-programs the FPGA with the corresponding core (e.g. `nestang.bin`) - at that moment the FPGA literally becomes an NES/SNES/GBA in hardware - then streams the ROM file into the core's memory over a fast UART link.
3. **While playing**: controller input and the in-game overlay menu are also handled by the BL616 and forwarded to the core over the same link.

Because cores are loaded into FPGA SRAM (not flash), core switching is fast and does not wear anything out. It also means the SD card / USB drive must stay inserted while playing.

The **BOOT button** on the board serves a different purpose: holding it while connecting USB puts the BL616 into its bootloader, which is only used for flashing the TangCore firmware itself with Bouffalo Flash Cube. In this mode the firmware does not run, so the screen stays at the TangCore logo and no menu appears.

