# Troubleshooting

## The menu shows "N/A" for every core

The firmware could not find the core bitstreams on your SD card / USB drive. Make sure the drive contains the `cores` directory from the release package, so that files like `/cores/console60k/nestang.bin` exist for your board model. Also see "The on-board SD card slot is not detected" below.

## The screen is stuck at the TangCore logo

If you held the BOOT button while connecting power/USB, the BL616 MCU is in bootloader (firmware flashing) mode and the TangCore firmware does not run. This mode is only needed for flashing firmware with Bouffalo Flash Cube. Reconnect power without holding BOOT to boot normally.

## There's no video output

Check the following,

* Have you flashed the correct firmware for your board with Bouffalo Flash Cube? There's one .ini file for each board.
* Make sure USB drive contains `/cores/<your_board>/monitor.bin`. This is the bitstream that displays the menu.
* For Primer/Console, use USB-OTG dongle with power pass-through to connect USB and power.
* For Mega, either use OTG or the USB-A Host port on the board to connect USB drive. If USB-A is used, make sure the switch below is set to "DBG" instead of "FPGA".
* Do NOT connect the board to PC for power when you intend to run TangCore. Use a separate power supply. The Sipeed firmware enters JTAG/debug mode when PC is detected.
* For Tang Mega, don't forget to turn on power (long press POWER button on top)

## I cannot navigate the menu

Check controller connection. Dualshock controller support is most stable:

* For Mega, insert the DS2 pmod into the left pmod socket (pmod0).
* For Console, use the top pmod socket (pmod1).
* For Primer, use the middle pmod socket for DS2.

If you use USB controllers,

* Only the Sipeed-provided USB gamepads can be used with the on-board USB-A port. If it is not recognized, replug the pad.
* Other types of USB gamepads needs a USB hub to work. Please follow instructions on the [controllers page](controllers.md).

## My ROM does not load ("Only .nes supported" and similar messages)

ROM files must be uncompressed. `.zip` files are not supported - extract them first. Each system only accepts its own extensions: `.nes` (NES), `.smc`/`.sfc` (SNES), `.gba` (GBA), `.bin`/`.md` (Genesis), `.sms` (SMS), `.img` (PC/XT floppy images).

## File names show up garbled in the menu

Non-ASCII file names (Chinese, Japanese, accented characters and so on) are not supported by the menu. Rename your ROM files using only ASCII letters, numbers and punctuation.

## Strange `._xxx` files appear in the file browser (macOS)

macOS creates hidden AppleDouble (`._*`) and Spotlight index files on removable drives. They are harmless but clutter the file list. Before ejecting the drive on macOS, clean them up:

```bash
dot_clean -m /Volumes/<your_drive> && find /Volumes/<your_drive> -name '._*' -delete
```

## The on-board SD card slot is not detected

The on-board SD card slot is only supported on Tang Console **v1.1** boards (since TangCore 0.9). On earlier boards, put the SD card in a USB card reader (or use a USB drive) and connect it through the USB-C OTG adapter instead.

